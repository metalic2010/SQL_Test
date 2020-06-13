USE [Test]
GO

/****** Object:  StoredProcedure [dbo].[Set_UpdatePass]    Script Date: 16.05.2020 18:27:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		����� �.�.
-- Create date: 16.05.2020
-- Description:	��������� ���������� ������
-- =============================================
CREATE PROCEDURE [dbo].[Set_UpdatePass]
     @ID_USER [uniqueidentifier]    -- ID ������������
    ,@PASS    [varchar](16)         -- ����� ������
    ,@result  [varchar](256) OUTPUT -- �����
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
    END

    UPDATE [Test].[dbo].[Users]
    SET [ENCRIPTPASS] = pwdencrypt(@PASS)
       ,[DateOfChange] = GETDATE()
    Where [ID_USER] = @ID_USER;

    SET @result = convert(varchar(256),@@rowcount)
    return
END

GO


