USE [Test]
GO

/****** Object:  Table [dbo].[TableOrder]    Script Date: 16.05.2020 18:21:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TableOrder](
	[NumOrder] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_USER] [uniqueidentifier] NOT NULL,
	[NameProduct] [varchar](256) NOT NULL,
	[CostProduct] [money] NOT NULL,
	[DateOfFormation] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO


