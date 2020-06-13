DECLARE @DOB             [date]               -- ���� �������� ������������
       ,@DOC             [datetime2](7)       -- ���� �������� ������ ������������
       ,@DOCh            [datetime2](7)       -- ���� ��������� ������ ������������
       ,@i               [int] = 0            -- ������� �����
       ,@CNT             [int] = 1000000      -- ����� ���������� ������� (������ ���� ������ ������)
       ,@part            [int] = 1000         -- ���������� ������� � ����� ������ (����������� 1000)
       ,@_LastName       [varchar](32)        -- ������� ������������
       ,@_FirstName      [varchar](32)        -- ��� ������������
       ,@_Patronymic     [varchar](32)        -- �������� ������������
       ,@_PASS           [varchar](16)        -- ������ ������������
       ,@_Gender         [char](4)            -- ��� ������������
       ,@_Email          [varchar](128)       -- email ������������
       ,@_Phone          [bigint]             -- ������� ������������
       ,@_DateOfBirth    [date]               -- ���� �������� ������������
       ,@_DateOfCreation [datetime2](0)       -- ���� �������� ������ ������������
       ,@_DateOfChange   [datetime2](0)       -- ���� ��������� ������ ������������
       ,@_Country        [varchar](60)        -- ������ ������������
       ,@_City           [varchar](60)        -- ����� ������������
       ,@_Address        [varchar](512)       -- ����� ������������
       ,@Num [bigint]                         -- ������� ������������
       ,@G varchar(8) = '���.���.'            -- ��� ������������
       ,@FromDate datetime2(7) = '2011-01-01' -- ���� ������
       ,@ToDate datetime2(7) = '2020-03-30'   -- ���� ���������
       ,@SQLQuery varchar(max) = '';          -- ������ (��� ������������ ������� ������)

-- ����, ��������� ������ ��� ���������� � �������
while (@i < @CNT)
BEGIN
    --����������� ������� �� 1
    SET @i += 1;

    --��������� ����� �� 1001001001 �� 9999999999
    --��� ������������ ������ ��������
    SET @Num = FLOOR(RAND()*(9999999999-1001001001+1)+1001001001);

    --��������� ���� ��������
    SET @DOB = dateadd(SECOND,rand()*(1+datediff(day, @FromDate, @ToDate)),
                dateadd(minute,rand()*(1+datediff(day, @FromDate, @ToDate)),
                 dateadd(HOUR,rand()*(1+datediff(day, @FromDate, @ToDate)),
                  dateadd(day,rand()*(1+datediff(day, @FromDate, @ToDate)),@FromDate))));
    
    --��������� ���� ������ � �������
    SET @DOC = dateadd(day,rand()*(1+datediff(day, @DOB, GETDATE())),@DOB);

    --��������� ���� ��������� ������
    SET @DOCh = dateadd(day,rand()*(1+datediff(day, @DOB, GETDATE())),@DOB);

    --���������� ���������� � ����������
    Select @_LastName = '�������'+convert(varchar(25),@i)    -- ������� ������������
          ,@_FirstName = '���'+convert(varchar(25),@i)       -- ��� ������������
          ,@_Patronymic = '��������'+convert(varchar(25),@i) -- �������� ������������
          ,@_PASS = '������'+convert(varchar(25),@i)         -- ������ ������������
          ,@_Gender = CASE WHEN FLOOR(RAND()*2+1) = 1 THEN Substring(@G,convert(int,FLOOR(RAND()*0+1)),4)
                      ELSE Substring(@G,convert(int,FLOOR(RAND()*(6-5)+5)),4) END -- ��� ������������
          ,@_Email = 'email1@mail.ru'                       -- email ������������
          ,@_Phone = '8'+convert(char(10),@Num)             -- ������� ������������
          ,@_DateOfBirth = @DOB                             -- ���� �������� ������������
          ,@_DateOfCreation = @DOC                          -- ���� �������� ������ ������������
          ,@_DateOfChange = @DOCh                           -- ���� ��������� ������ ������������
          ,@_Country = '������'                             -- ������ ������������
          ,@_City = '������'                                -- ����� ������������
          ,@_Address = '�����'+convert(varchar(25),@i)       -- ����� ������������
    
    --��������� ������
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
    
    --��������� ������ ������� ��� ���
    if (@i % @part) = 0
    BEGIN
        --������� ��������� �������
        SET @SQLQuery = SUBSTRING(@SQLQuery,1,LEN(@SQLQuery)-1);

        --������� ���������� � ��� ����� ������ ����� �� ������
        print @i;

        --���������� � �������
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

        --�������� ������ �������
        SET @SQLQuery = '';
    END
END