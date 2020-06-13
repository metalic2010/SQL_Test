-- ��������� ������
declare some_cursor cursor for select distinct [ID_USER] from [Test].[dbo].[Users];

-- ��������� ������
open some_cursor;

-- ��������� ���������� � ������� ����� ����� � �����
declare  @counter int = 0
        ,@ListID_USER uniqueidentifier
        ,@CNT int = 100; --����� ���������� ��������

-- ������� ������  ������
fetch next from some_cursor INTO  @ListID_USER;

-- ���� � ������� � �������� ���� ����������� ����� ����� ������
while @@FETCH_STATUS = 0
begin
    --������������ �������
    set @counter += 1
    if @counter > @CNT break  -- ��������� ��� ��� �������� ������, ��������� ����� ����� ��������
    
    DECLARE @_ID_USER uniqueidentifier = @ListID_USER  --ID ������������
           ,@_NameProduct varchar(256) = ''            --������������ ������
           ,@_CostProduct money = 0                    --��������� ������
           ,@_DateOfFormation datetime2(7) = GETDATE() --���� ������
           ,@CNTOrder int = 10                         --����� ����������
           ,@i int = 0                                 --������� ���������� (�������)

    WHILE (@i < @CNT)
    BEGIN
        SET @i += 1;
    
        SET @_NameProduct = '�����'+convert(varchar(10),@i);
        SET @_CostProduct = (Select ROUND(RAND()*100+1,2));
    
        EXEC [Test].[dbo].[Set_Order] @ID_USER = @_ID_USER
                                     ,@NameProduct = @_NameProduct
                                     ,@CostProduct = @_CostProduct
                                     ,@DateOfFormation = @_DateOfFormation;

        print '�������� '+convert(varchar(10),@counter)+', �����: '+convert(varchar(10),@i);
    END;

    -- ������� ��������� ������
    fetch next from some_cursor INTO  @ListID_USER;

end

-- ��������� ������
close some_cursor
deallocate some_cursor
