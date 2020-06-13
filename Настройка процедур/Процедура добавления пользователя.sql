USE [Test]
GO

/****** Object:  StoredProcedure [dbo].[Set_AddUser]    Script Date: 16.05.2020 18:25:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Савин А.С.
-- Create date: 16.05.2020
-- Description:	Процедура добавления пользователя
-- =============================================
CREATE PROCEDURE [dbo].[Set_AddUser]
     @LastName       [varchar](32)   -- Фамилия пользователя
    ,@FirstName      [varchar](32)   -- Имя пользователя
    ,@Patronymic     [varchar](32)   -- Отчество пользователя
    ,@PASS           [varchar](16)   -- Пароль пользователя
    ,@Gender         [char](4)       -- пол пользователя
    ,@Email          [varchar](128)  -- email пользователя
    ,@Phone          [bigint]         -- телефон пользователя
    ,@DateOfBirth    [date]           -- дата рождения пользователя
    ,@DateOfCreation [datetime2](0)   -- дата создания учётки пользователя
    ,@DateOfChange   [datetime2](0)   -- дата изменения данных пользователя
    ,@Country        [varchar](60)   -- страна пользователя
    ,@City           [varchar](60)   -- город пользователя
    ,@Address        [varchar](512)  -- адрес пользователя
    ,@result         [varchar](256) OUTPUT -- Ответ
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
    END;

    INSERT INTO [Test].[dbo].[Users]
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
    VALUES
        (NEWID()
        ,@LastName
        ,@FirstName
        ,@Patronymic
        ,pwdencrypt(@PASS)
        ,@Gender
        ,@Email
        ,@Phone
        ,@DateOfBirth
        ,@DateOfCreation
        ,@DateOfChange
        ,@Country
        ,@City
        ,@Address)

    SET @result = convert(varchar(256),@@rowcount)
    return
END
GO


