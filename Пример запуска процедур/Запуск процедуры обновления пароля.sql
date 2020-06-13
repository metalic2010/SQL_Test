DECLARE @_result  [varchar](256) = ''
       ,@_ID_USER [uniqueidentifier] = 'F9C4463B-C410-4A4F-B8CC-4F2B9D265748'
       ,@_PASS [varchar](16) = 'Мой пароль';

EXEC [Test].[dbo].[Set_UpdatePass] @ID_USER = @_ID_USER
                                  ,@PASS = @_PASS
                                  ,@result = @_result output

print @_result