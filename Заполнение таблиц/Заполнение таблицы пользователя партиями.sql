DECLARE @DOB             [date]               -- дата рождения пользователя
       ,@DOC             [datetime2](7)       -- дата создания учётки пользователя
       ,@DOCh            [datetime2](7)       -- дата изменения данных пользователя
       ,@i               [int] = 0            -- счётчик цикла
       ,@CNT             [int] = 1000000      -- Общее количество записей (должно быть дробно партии)
       ,@part            [int] = 1000         -- Количество записей в одной партии (мксимальное 1000)
       ,@_LastName       [varchar](32)        -- Фамилия пользователя
       ,@_FirstName      [varchar](32)        -- Имя пользователя
       ,@_Patronymic     [varchar](32)        -- Отчество пользователя
       ,@_PASS           [varchar](16)        -- Пароль пользователя
       ,@_Gender         [char](4)            -- пол пользователя
       ,@_Email          [varchar](128)       -- email пользователя
       ,@_Phone          [bigint]             -- телефон пользователя
       ,@_DateOfBirth    [date]               -- дата рождения пользователя
       ,@_DateOfCreation [datetime2](0)       -- дата создания учётки пользователя
       ,@_DateOfChange   [datetime2](0)       -- дата изменения данных пользователя
       ,@_Country        [varchar](60)        -- страна пользователя
       ,@_City           [varchar](60)        -- город пользователя
       ,@_Address        [varchar](512)       -- адрес пользователя
       ,@Num [bigint]                         -- телефон пользователя
       ,@G varchar(8) = 'Муж.Жен.'            -- пол пользователя
       ,@FromDate datetime2(7) = '2011-01-01' -- дата начала
       ,@ToDate datetime2(7) = '2020-03-30'   -- дата окончания
       ,@SQLQuery varchar(max) = '';          -- запрос (для формирования запроса партии)

-- Цикл, формируем партии для добавления в таблицу
while (@i < @CNT)
BEGIN
    --Увеличиваем счётчик на 1
    SET @i += 1;

    --Случайное число от 1001001001 до 9999999999
    --для формирования номера телефона
    SET @Num = FLOOR(RAND()*(9999999999-1001001001+1)+1001001001);

    --Формируем дату рождения
    SET @DOB = dateadd(SECOND,rand()*(1+datediff(day, @FromDate, @ToDate)),
                dateadd(minute,rand()*(1+datediff(day, @FromDate, @ToDate)),
                 dateadd(HOUR,rand()*(1+datediff(day, @FromDate, @ToDate)),
                  dateadd(day,rand()*(1+datediff(day, @FromDate, @ToDate)),@FromDate))));
    
    --Формируем дату записи в таблицу
    SET @DOC = dateadd(day,rand()*(1+datediff(day, @DOB, GETDATE())),@DOB);

    --Формируем дату изменения записи
    SET @DOCh = dateadd(day,rand()*(1+datediff(day, @DOB, GETDATE())),@DOB);

    --Записываем информацию в переменные
    Select @_LastName = 'Фамилия'+convert(varchar(25),@i)    -- Фамилия пользователя
          ,@_FirstName = 'Имя'+convert(varchar(25),@i)       -- Имя пользователя
          ,@_Patronymic = 'Отчество'+convert(varchar(25),@i) -- Отчество пользователя
          ,@_PASS = 'пароль'+convert(varchar(25),@i)         -- Пароль пользователя
          ,@_Gender = CASE WHEN FLOOR(RAND()*2+1) = 1 THEN Substring(@G,convert(int,FLOOR(RAND()*0+1)),4)
                      ELSE Substring(@G,convert(int,FLOOR(RAND()*(6-5)+5)),4) END -- пол пользователя
          ,@_Email = 'email1@mail.ru'                       -- email пользователя
          ,@_Phone = '8'+convert(char(10),@Num)             -- телефон пользователя
          ,@_DateOfBirth = @DOB                             -- дата рождения пользователя
          ,@_DateOfCreation = @DOC                          -- дата создания учётки пользователя
          ,@_DateOfChange = @DOCh                           -- дата изменения данных пользователя
          ,@_Country = 'Россия'                             -- страна пользователя
          ,@_City = 'Москва'                                -- город пользователя
          ,@_Address = 'Адрес'+convert(varchar(25),@i)       -- адрес пользователя
    
    --Формируем запрос
    SET @SQLQuery += (Select '(NEWID()'
                            +',''' + @_LastName + ''''
                            +',''' + @_FirstName + ''''
                            +',''' + @_Patronymic + ''''
                            +',pwdencrypt(''' + @_PASS + ''')'
                            +',''' + @_Gender + ''''
                            +',''' + @_Email + ''''
                            +',''' + convert(varchar(11),@_Phone) + ''''
                            +',''' + convert(varchar(200),@_DateOfBirth) + ''''
                            +',''' + convert(varchar(200),@_DateOfCreation) + ''''
                            +',''' + convert(varchar(200),@_DateOfChange) + ''''
                            +',''' + @_Country + ''''
                            +',''' + @_City + ''''
                            +',''' + @_Address + '''),');
    
    --Проверяем партия собрана или нет
    if (@i % @part) = 0
    BEGIN
        --Удаляем последнюю запятую
        SET @SQLQuery = SUBSTRING(@SQLQuery,1,LEN(@SQLQuery)-1);

        --Выводим информацию о том какая партия пошла на запись
        print @i;

        --Записываем в таблицу
        EXEC (N'INSERT INTO [Test].[dbo].[Users] WITH (TABLOCK)
                ([ID_USER]
                ,[LastName]
                ,[FirstName]
                ,[Patronymic]
                ,[ENCRIPTPASS]
                ,[Gender]
                ,[Email]
                ,[Phone]
                ,[DateOfBirth]
                ,[DateOfCreation]
                ,[DateOfChange]
                ,[Country]
                ,[City]
                ,[Address])
                VALUES '+@SQLQuery);

        --Обнуляем строку запроса
        SET @SQLQuery = '';
    END
END