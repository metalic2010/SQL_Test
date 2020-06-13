
with res as (
    --Выбираем те столбцы, которые нам необходимы
    SELECT t1.[DateOfFormation]
          ,t1.[ID_USER]
          ,t1.[CostProduct]
    FROM [Test].[dbo].[TableOrder] t1
    --слияние с таблицей пользователей, что бы выбрать только новых
    --период новых задаём в where
    join (SELECT [ID_USER]
          FROM [Test].[dbo].[Users]
          Where [DateOfCreation] >= DATEADD(DAY,-10,GETDATE())) t2 ON t1.[ID_USER] = t2.[ID_USER]
    --слияние с этой же таблицей для получения даты первого заказа
    CROSS APPLY (Select tin.[ID_USER]
                       ,MIN(tin.[DateOfFormation]) as [MAXDateOfFormation]
                 FROM [Test].[dbo].[TableOrder] tin
                 Where tin.[ID_USER] = t1.[ID_USER]
                 GROUP BY tin.[ID_USER]) catin
    Where catin.[MAXDateOfFormation] = t1.[DateOfFormation]
      and catin.[ID_USER] = t1.[ID_USER]
)
--Группировка по каждому клиенту выводит сумму его первого заказа
Select [DateOfFormation]
      ,[ID_USER]
      ,SUM([CostProduct]) as [Сумма заказа]
FROM res
GROUP BY [DateOfFormation],[ID_USER]