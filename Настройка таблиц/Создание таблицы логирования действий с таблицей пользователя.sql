USE [Test]
GO

/****** Object:  Table [dbo].[Log_ActionUsers]    Script Date: 16.05.2020 18:20:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Log_ActionUsers](
	[ID] [uniqueidentifier] NOT NULL,
	[ID_USER] [uniqueidentifier] NOT NULL,
	[ACTION] [varchar](256) NOT NULL,
	[DateAction] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Log_ActionUsers] ADD  DEFAULT (newid()) FOR [ID]
GO

ALTER TABLE [dbo].[Log_ActionUsers] ADD  DEFAULT (getdate()) FOR [DateAction]
GO


