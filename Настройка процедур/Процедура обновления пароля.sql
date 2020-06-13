USE [Test]
GO

/****** Object:  StoredProcedure [dbo].[Set_UpdatePass]    Script Date: 16.05.2020 18:27:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Савин А.С.
-- Create date: 16.05.2020
-- Description:	Процедура обновления пароля
-- =============================================
CREATE PROCEDURE [dbo].[Set_UpdatePass]
     @ID_USER [uniqueidentifier]    -- ID пользователя
    ,@PASS    [varchar](16)         -- Новый пароль
    ,@result  [varchar](256) OUTPUT -- Ответ
AS
BEGIN
    SET NOCOUNT ON;

    set @PASS = isnull(@PASS,'');

    if (@PASS = '')
    BEGIN
        SET @result = 'Пустой пароль не допустим.'
        return
    END;

    if (LEN(@PASS) < 8)
    BEGIN
        SET @result = 'Пароль меньше 8 символов не допустим.'
        return
    END

    UPDATE [Test].[dbo].[Users]
    SET [ENCRIPTPASS] = pwdencrypt(@PASS)
       ,[DateOfChange] = GETDATE()
    Where [ID_USER] = @ID_USER;

    SET @result = convert(varchar(256),@@rowcount)
    return
END

GO


