-- обьявляем курсор
declare some_cursor cursor for select distinct [ID_USER] from [Test].[dbo].[Users];

-- открываем курсор
open some_cursor;

-- обьявляем переменные и обходим набор строк в цикле
declare  @counter int = 0
        ,@ListID_USER uniqueidentifier
        ,@CNT int = 100; --общее количество итераций

-- выборка первой  строки
fetch next from some_cursor INTO  @ListID_USER;

-- цикл с логикой и выборкой всех последующих строк после первой
while @@FETCH_STATUS = 0
begin
    --уввеличиваем счётчик
    set @counter += 1
    if @counter > @CNT break  -- возможный код для проверки работы, прерываем после пятой итерации
    
    DECLARE @_ID_USER uniqueidentifier = @ListID_USER  --ID пользователя
           ,@_NameProduct varchar(256) = ''            --Наименование товара
           ,@_CostProduct money = 0                    --Стоимость товара
           ,@_DateOfFormation datetime2(7) = GETDATE() --Дата заказа
           ,@CNTOrder int = 10                         --Общее количество
           ,@i int = 0                                 --текущее количество (счётчик)

    WHILE (@i < @CNT)
    BEGIN
        SET @i += 1;
    
        SET @_NameProduct = 'Товар'+convert(varchar(10),@i);
        SET @_CostProduct = (Select ROUND(RAND()*100+1,2));
    
        EXEC [Test].[dbo].[Set_Order] @ID_USER = @_ID_USER
                                     ,@NameProduct = @_NameProduct
                                     ,@CostProduct = @_CostProduct
                                     ,@DateOfFormation = @_DateOfFormation;

        print 'Итерация '+convert(varchar(10),@counter)+', товар: '+convert(varchar(10),@i);
    END;

    -- выборка следующей строки
    fetch next from some_cursor INTO  @ListID_USER;

end

-- закрываем курсор
close some_cursor
deallocate some_cursor
