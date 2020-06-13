USE [Test]
GO

/****** Object:  StoredProcedure [dbo].[Set_Order]    Script Date: 16.05.2020 18:26:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Савин А.С.
-- Create date: 16.05.2020
-- Description:	Процедура добавления заказа
-- =============================================
CREATE PROCEDURE [dbo].[Set_Order]
    @ID_USER [uniqueidentifier]
   ,@NameProduct [varchar](256)
   ,@CostProduct [money]
   ,@DateOfFormation [datetime2](7)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Test].[dbo].[TableOrder]
        ([ID_USER]
        ,[NameProduct]
        ,[CostProduct]
        ,[DateOfFormation])
    VALUES (@ID_USER, @NameProduct, @CostProduct, @DateOfFormation);
END
GO


