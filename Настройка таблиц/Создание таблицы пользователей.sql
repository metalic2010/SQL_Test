USE [Test]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 16.05.2020 18:21:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[ID_USER] [uniqueidentifier] NOT NULL,
	[LastName] [varchar](32) NOT NULL,
	[FirstName] [varchar](32) NOT NULL,
	[Patronymic] [varchar](32) NOT NULL,
	[ENCRIPTPASS] [varbinary](256) NOT NULL,
	[Gender] [nchar](4) NOT NULL,
	[Email] [varchar](128) NOT NULL,
	[Phone] [bigint] NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[DateOfCreation] [datetime2](0) NOT NULL,
	[DateOfChange] [datetime2](0) NOT NULL,
	[Country] [varchar](60) NOT NULL,
	[City] [varchar](60) NOT NULL,
	[Address] [varchar](512) NOT NULL,
	[ACTIVE] [bit] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [ACTIVE]
GO


