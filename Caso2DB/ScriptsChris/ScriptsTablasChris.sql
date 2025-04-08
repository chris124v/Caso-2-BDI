USE [Caso2]
GO
/****** Object:  Table [dbo].[SocaiCurrencyExchange]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCurrencyExchange](
	[CurrencyExchangeId] [int] IDENTITY(1,1) NOT NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[exchangeRate] [decimal](18, 2) NULL,
	[enabled] [bit] NULL,
	[currentExchangeRate] [bit] NULL,
	[CurrencyTypeId] [int] NOT NULL,
	[CurrencyTypeDestinyId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiCurrencyExchange] PRIMARY KEY CLUSTERED 
(
	[CurrencyExchangeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCurrencyTypes]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCurrencyTypes](
	[CurrencyTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NULL,
	[acronym] [varchar](10) NULL,
	[symbol] [varchar](5) NULL,
 CONSTRAINT [PK_SocaiCurrencyTypes] PRIMARY KEY CLUSTERED 
(
	[CurrencyTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiDataPayments]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiDataPayments](
	[DataPaymentId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NULL,
	[token] [varbinary](255) NULL,
	[expToken] [datetime] NULL,
	[maskAccount] [varbinary](255) NULL,
	[UserId] [int] NOT NULL,
	[PaymentMethodId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiDataPayments] PRIMARY KEY CLUSTERED 
(
	[DataPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiFiles]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiFiles](
	[FileId] [int] IDENTITY(1,1) NOT NULL,
	[fileName] [varchar](200) NULL,
	[description] [varchar](300) NULL,
	[fileURL] [varchar](250) NULL,
	[deleted] [bit] NULL,
	[lastUpdated] [datetime] NULL,
	[creation] [datetime] NOT NULL,
	[fileSize] [bigint] NULL,
	[mimeType] [varchar](5) NULL,
	[UserId] [int] NOT NULL,
	[FileTypeId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiFiles] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiFileTypes]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiFileTypes](
	[FileTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](35) NULL,
	[mimeType] [varchar](5) NULL,
	[icon] [varchar](200) NULL,
	[enabled] [bit] NULL,
 CONSTRAINT [PK_SocaiFileTypes] PRIMARY KEY CLUSTERED 
(
	[FileTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiPaymentMethods]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiPaymentMethods](
	[PaymentMethodId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NULL,
	[apiURL] [varchar](250) NULL,
	[secretKey] [varbinary](255) NULL,
	[key] [varbinary](255) NULL,
	[logoIconURL] [varchar](200) NULL,
	[enable] [bit] NOT NULL,
 CONSTRAINT [PK_SocaiPaymentMethods] PRIMARY KEY CLUSTERED 
(
	[PaymentMethodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiPayments]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiPayments](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[amount] [decimal](15, 0) NULL,
	[actualAmount] [decimal](15, 0) NULL,
	[authentication] [varchar](200) NULL,
	[reference] [varchar](200) NULL,
	[chargeToken] [varbinary](250) NULL,
	[date] [datetime] NULL,
	[checksum] [varbinary](250) NULL,
	[DataPaymentId] [int] NOT NULL,
	[PaymentMethodId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[ResultPaymentId] [int] NOT NULL,
	[CurrencyTypeId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiPayments] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiResultPayment]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiResultPayment](
	[ResultPaymentId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NULL,
	[description] [varchar](300) NULL,
 CONSTRAINT [PK_SocaiResultPayment] PRIMARY KEY CLUSTERED 
(
	[ResultPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiTransactions]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiTransactions](
	[TransactionId] [int] IDENTITY(1,1) NOT NULL,
	[amount] [decimal](15, 2) NULL,
	[description] [varchar](300) NULL,
	[transactionDateTime] [datetime] NULL,
	[postTime] [datetime] NULL,
	[referenceNumber] [varchar](200) NULL,
	[checksum] [varbinary](255) NULL,
	[TransactionTypeId] [int] NOT NULL,
	[TransactionSubTypeId] [int] NOT NULL,
	[CurrencyTypeId] [int] NOT NULL,
	[PaymentId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[ExchangeRateId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiTransactionSubTypes]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiTransactionSubTypes](
	[TransactionSubTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](35) NULL,
	[description] [varchar](300) NULL,
 CONSTRAINT [PK_SocaiTransactionSubTypes] PRIMARY KEY CLUSTERED 
(
	[TransactionSubTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiTransactionTypes]    Script Date: 30/3/2025 19:01:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiTransactionTypes](
	[TransactionTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](35) NULL,
	[description] [varchar](300) NULL,
 CONSTRAINT [PK_SocaiTransactionTypes] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SocaiFileTypes] ADD  CONSTRAINT [DF_SocaiFileTypes_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[SocaiCurrencyExchange]  WITH CHECK ADD  CONSTRAINT [CurrencyTypeDestinyIdFK] FOREIGN KEY([CurrencyTypeDestinyId])
REFERENCES [dbo].[SocaiCurrencyTypes] ([CurrencyTypeId])
GO
ALTER TABLE [dbo].[SocaiCurrencyExchange] CHECK CONSTRAINT [CurrencyTypeDestinyIdFK]
GO
ALTER TABLE [dbo].[SocaiCurrencyExchange]  WITH CHECK ADD  CONSTRAINT [CurrencyTypeIdFK] FOREIGN KEY([CurrencyTypeId])
REFERENCES [dbo].[SocaiCurrencyTypes] ([CurrencyTypeId])
GO
ALTER TABLE [dbo].[SocaiCurrencyExchange] CHECK CONSTRAINT [CurrencyTypeIdFK]
GO
ALTER TABLE [dbo].[SocaiFiles]  WITH CHECK ADD  CONSTRAINT [FileTypeIdFK] FOREIGN KEY([FileTypeId])
REFERENCES [dbo].[SocaiFileTypes] ([FileTypeId])
GO
ALTER TABLE [dbo].[SocaiFiles] CHECK CONSTRAINT [FileTypeIdFK]
GO
ALTER TABLE [dbo].[SocaiPayments]  WITH CHECK ADD  CONSTRAINT [DataPaymentIdFK] FOREIGN KEY([DataPaymentId])
REFERENCES [dbo].[SocaiDataPayments] ([DataPaymentId])
GO
ALTER TABLE [dbo].[SocaiPayments] CHECK CONSTRAINT [DataPaymentIdFK]
GO
ALTER TABLE [dbo].[SocaiPayments]  WITH CHECK ADD  CONSTRAINT [FK_SocaiPayments_SocaiCurrencyTypes] FOREIGN KEY([CurrencyTypeId])
REFERENCES [dbo].[SocaiCurrencyTypes] ([CurrencyTypeId])
GO
ALTER TABLE [dbo].[SocaiPayments] CHECK CONSTRAINT [FK_SocaiPayments_SocaiCurrencyTypes]
GO
ALTER TABLE [dbo].[SocaiPayments]  WITH CHECK ADD  CONSTRAINT [PaymentMethodIdFK] FOREIGN KEY([PaymentMethodId])
REFERENCES [dbo].[SocaiPaymentMethods] ([PaymentMethodId])
GO
ALTER TABLE [dbo].[SocaiPayments] CHECK CONSTRAINT [PaymentMethodIdFK]
GO
ALTER TABLE [dbo].[SocaiPayments]  WITH CHECK ADD  CONSTRAINT [ResultPaymentIdFK] FOREIGN KEY([ResultPaymentId])
REFERENCES [dbo].[SocaiResultPayment] ([ResultPaymentId])
GO
ALTER TABLE [dbo].[SocaiPayments] CHECK CONSTRAINT [ResultPaymentIdFK]
GO
ALTER TABLE [dbo].[SocaiTransactions]  WITH CHECK ADD  CONSTRAINT [CurrencyTypesIdFK] FOREIGN KEY([CurrencyTypeId])
REFERENCES [dbo].[SocaiCurrencyTypes] ([CurrencyTypeId])
GO
ALTER TABLE [dbo].[SocaiTransactions] CHECK CONSTRAINT [CurrencyTypesIdFK]
GO
ALTER TABLE [dbo].[SocaiTransactions]  WITH CHECK ADD  CONSTRAINT [ExchangeRateIdFK] FOREIGN KEY([ExchangeRateId])
REFERENCES [dbo].[SocaiCurrencyExchange] ([CurrencyExchangeId])
GO
ALTER TABLE [dbo].[SocaiTransactions] CHECK CONSTRAINT [ExchangeRateIdFK]
GO
ALTER TABLE [dbo].[SocaiTransactions]  WITH CHECK ADD  CONSTRAINT [PaymentIdFK] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[SocaiPayments] ([PaymentId])
GO
ALTER TABLE [dbo].[SocaiTransactions] CHECK CONSTRAINT [PaymentIdFK]
GO
ALTER TABLE [dbo].[SocaiTransactions]  WITH CHECK ADD  CONSTRAINT [TransactionSubTypeIdFK] FOREIGN KEY([TransactionSubTypeId])
REFERENCES [dbo].[SocaiTransactionSubTypes] ([TransactionSubTypeId])
GO
ALTER TABLE [dbo].[SocaiTransactions] CHECK CONSTRAINT [TransactionSubTypeIdFK]
GO
ALTER TABLE [dbo].[SocaiTransactions]  WITH CHECK ADD  CONSTRAINT [TransactionTypeIdFK] FOREIGN KEY([TransactionTypeId])
REFERENCES [dbo].[SocaiTransactionTypes] ([TransactionTypeId])
GO
ALTER TABLE [dbo].[SocaiTransactions] CHECK CONSTRAINT [TransactionTypeIdFK]
GO
