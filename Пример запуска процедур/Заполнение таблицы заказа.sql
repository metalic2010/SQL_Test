
DECLARE @_ID_USER uniqueidentifier = '8D845C03-23BE-4189-8975-00000A57F7F6' --ID пользователя
       ,@_NameProduct varchar(256) = 'Товар'                                --Наименование товара
       ,@_CostProduct money = 135.6                                         --Стоимость товара
       ,@_DateOfFormation datetime2(7) = GETDATE();                         --Дата заказа


    EXEC [Test].[dbo].[Set_Order] @ID_USER = @_ID_USER
                                 ,@NameProduct = @_NameProduct
                                 ,@CostProduct = @_CostProduct
                                 ,@DateOfFormation = @_DateOfFormation;

