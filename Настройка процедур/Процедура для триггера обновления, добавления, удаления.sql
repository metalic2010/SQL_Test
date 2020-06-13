USE [Test]
GO

/****** Object:  StoredProcedure [dbo].[Set_TriggerAction]    Script Date: 16.05.2020 18:26:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Савин А.С.
-- Create date: 16.05.2020
-- Description:	Процедура для триггера обновления, добавления, удаления
-- =============================================
CREATE PROCEDURE [dbo].[Set_TriggerAction]
    @ID_USER [uniqueidentifier]
   ,@ActionName [varchar](6)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [Test].[dbo].[Log_ActionUsers]
        ([ID_USER]
        ,[ACTION])
    VALUES (@ID_USER, @ActionName);
END
GO


