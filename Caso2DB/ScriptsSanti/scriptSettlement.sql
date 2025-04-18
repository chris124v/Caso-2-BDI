﻿USE [caso2]
GO
/****** Object:  Table [dbo].[SocaiCommerceBalance]    Script Date: 31/3/2025 16:29:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerceBalance](
	[commerceBalanceId] [int] IDENTITY(1,1) NOT NULL,
	[currentBalance] [decimal](18, 2) NOT NULL,
	[lastSettlementDate] [datetime] NULL,
	[updatedAt] [datetime] NOT NULL,
	[CommerceId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerceSettlement]    Script Date: 31/3/2025 16:29:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerceSettlement](
	[commerceSettlementId] [int] IDENTITY(1,1) NOT NULL,
	[settlementPeriodStart] [datetime] NOT NULL,
	[settlementPeriodEnd] [datetime] NOT NULL,
	[totalGross] [decimal](18, 2) NOT NULL,
	[totalCommission] [decimal](18, 2) NOT NULL,
	[totalNet] [decimal](18, 2) NOT NULL,
	[settlementDate] [datetime] NULL,
	[status] [varchar](20) NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
	[CommerceId] [int] NULL,
 CONSTRAINT [PK_SocaiCommerceSettlement] PRIMARY KEY CLUSTERED 
(
	[commerceSettlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerceSettlementDetail]    Script Date: 31/3/2025 16:29:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerceSettlementDetail](
	[commerceSettlementDetailId] [int] IDENTITY(1,1) NOT NULL,
	[grossAmount] [decimal](18, 2) NOT NULL,
	[commission] [decimal](18, 2) NOT NULL,
	[netAmount] [decimal](18, 2) NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
	[commerceSettlementId] [int] NOT NULL,
	[TransactionId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiCommerceSettlementDetail] PRIMARY KEY CLUSTERED 
(
	[commerceSettlementDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SocaiCommerceBalance] ADD  CONSTRAINT [DF_SocaiCommerceBalance_currentBalance]  DEFAULT ((0)) FOR [currentBalance]
GO
ALTER TABLE [dbo].[SocaiCommerceBalance] ADD  CONSTRAINT [DF_SocaiCommerceBalance_updatedAt]  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlement] ADD  CONSTRAINT [DF_SocaiCommerceSettlement_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail] ADD  CONSTRAINT [DF_SocaiCommerceSettlementDetail_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail]  WITH CHECK ADD  CONSTRAINT [FK_SocaiCommerceSettlementDetail_SocaiCommerceSettlement] FOREIGN KEY([commerceSettlementId])
REFERENCES [dbo].[SocaiCommerceSettlement] ([commerceSettlementId])
GO
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail] CHECK CONSTRAINT [FK_SocaiCommerceSettlementDetail_SocaiCommerceSettlement]
GO
