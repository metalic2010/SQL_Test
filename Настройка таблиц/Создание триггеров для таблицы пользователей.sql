USE [Test]
GO

/****** Object:  Trigger [dbo].[Action_Users]    Script Date: 16.05.2020 18:24:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[Action_Users]
ON [Test].[dbo].[Users]
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @_ID_USER [uniqueidentifier]
           ,@_ActionName [varchar](6);

    if exists (Select * from inserted) and not exists(Select * from deleted)
    BEGIN
        Select @_ID_USER = [ID_USER]
        from inserted;

        EXEC [Test].[dbo].[Set_TriggerAction] @ID_USER = @_ID_USER, @ActionName = 'INSERT';
    END;

    If exists(select * from deleted) and not exists(Select * from inserted)
    BEGIN
        Select @_ID_USER = [ID_USER]
        from deleted;

        EXEC [Test].[dbo].[Set_TriggerAction] @ID_USER = @_ID_USER, @ActionName = 'DELETE';
    END;
END
GO

ALTER TABLE [dbo].[Users] ENABLE TRIGGER [Action_Users]
GO


USE [Test]
GO

/****** Object:  Trigger [dbo].[Action_UsersUpdate]    Script Date: 16.05.2020 18:24:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[Action_UsersUpdate]
ON [Test].[dbo].[Users]
AFTER UPDATE
AS
BEGIN
    DECLARE @_ID_USER [uniqueidentifier]
           ,@_ActionName [varchar](6);

    Select @_ID_USER = [ID_USER]
    from inserted;
    
    EXEC [Test].[dbo].[Set_TriggerAction] @ID_USER = @_ID_USER, @ActionName = 'UPDATE';
END
GO

ALTER TABLE [dbo].[Users] ENABLE TRIGGER [Action_UsersUpdate]
GO

USE [Test]
GO
/****** Object:  Trigger [dbo].[user_delete]    Script Date: 16.05.2020 18:24:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[user_delete]
ON [Test].[dbo].[Users]
INSTEAD OF DELETE
AS
BEGIN
    UPDATE [Test].[dbo].[Users]
    SET [ACTIVE] = 0 -- 0 - это заблокирован или удалён
    WHERE [ID_USER] =(SELECT [ID_USER] FROM deleted);
END