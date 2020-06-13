USE [Test]
GO

/****** Object:  StoredProcedure [dbo].[Set_AddUser]    Script Date: 16.05.2020 18:25:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		����� �.�.
-- Create date: 16.05.2020
-- Description:	��������� ���������� ������������
-- =============================================
CREATE PROCEDURE [dbo].[Set_AddUser]
     @LastName       [varchar](32)   -- ������� ������������
    ,@FirstName      [varchar](32)   -- ��� ������������
    ,@Patronymic     [varchar](32)   -- �������� ������������
    ,@PASS           [varchar](16)   -- ������ ������������
    ,@Gender         [char](4)       -- ��� ������������
    ,@Email          [varchar](128)  -- email ������������
    ,@Phone          [bigint]         -- ������� ������������
    ,@DateOfBirth    [date]           -- ���� �������� ������������
    ,@DateOfCreation [datetime2](0)   -- ���� �������� ������ ������������
    ,@DateOfChange   [datetime2](0)   -- ���� ��������� ������ ������������
    ,@Country        [varchar](60)   -- ������ ������������
    ,@City           [varchar](60)   -- ����� ������������
    ,@Address        [varchar](512)  -- ����� ������������
    ,@result         [varchar](256) OUTPUT -- �����
AS
BEGIN
    SET NOCOUNT ON;

    set @PASS = isnull(@PASS,'');

    if (@PASS = '')
    BEGIN
        SET @result = '������ ������ �� ��������.'
        return
    END;

    if (LEN(@PASS) < 8)
    BEGIN
        SET @result = '������ ������ 8 �������� �� ��������.'
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


