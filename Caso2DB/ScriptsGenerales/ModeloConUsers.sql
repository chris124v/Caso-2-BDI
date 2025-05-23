USE [Caso2]
GO
/****** Object:  Table [dbo].[SocaiAdresses]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiAdresses](
	[AddressId] [int] IDENTITY(1,1) NOT NULL,
	[PostalCode] [varchar](20) NOT NULL,
	[CityId] [int] NOT NULL,
	[direccion] [varchar](250) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[point] [geography] NULL,
 CONSTRAINT [PK_solturaAdresses] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiBalancePerPerson]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiBalancePerPerson](
	[BalancePerPersonId] [int] IDENTITY(1,1) NOT NULL,
	[currentBalance] [decimal](18, 2) NOT NULL,
	[updatedAt] [datetime] NULL,
	[SuscriptionUserId] [int] NOT NULL,
	[BalanceId] [int] NOT NULL,
	[FeaturesSubscriptionId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiBalancePerPerson] PRIMARY KEY CLUSTERED 
(
	[BalancePerPersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiBalances]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiBalances](
	[BalanceId] [int] IDENTITY(1,1) NOT NULL,
	[amount] [decimal](18, 2) NOT NULL,
	[movementDate] [datetime] NOT NULL,
	[description] [varchar](300) NULL,
	[createdAt] [datetime] NOT NULL,
	[BalanceTypeId] [int] NOT NULL,
	[CurrencyTypeId] [int] NOT NULL,
	[TransactionId] [int] NULL,
	[SubscriptionUserId] [int] NOT NULL,
	[FeaturesSubscriptionsId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiBalances] PRIMARY KEY CLUSTERED 
(
	[BalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiBalanceTypes]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiBalanceTypes](
	[BalanceTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](40) NULL,
	[description] [varchar](300) NULL,
 CONSTRAINT [PK_SocaiBalanceTypes] PRIMARY KEY CLUSTERED 
(
	[BalanceTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCities]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCities](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[ProvinciasId] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaCities] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerceBalance]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerceBalance](
	[CommerceBalanceId] [int] IDENTITY(1,1) NOT NULL,
	[currentBalance] [decimal](18, 2) NOT NULL,
	[lastSettlementDate] [datetime] NULL,
	[updatedAt] [datetime] NOT NULL,
	[CommerceId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiCommerceBalance] PRIMARY KEY CLUSTERED 
(
	[CommerceBalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerceContactPerson]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerceContactPerson](
	[ContactPersonId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[Position] [varchar](100) NULL,
	[Department] [varchar](100) NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Email] [varchar](100) NULL,
	[CommerceId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiCommerceContactPerson] PRIMARY KEY CLUSTERED 
(
	[ContactPersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerces]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerces](
	[CommerceId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](225) NULL,
	[Description] [varchar](250) NULL,
	[AddressId] [int] NOT NULL,
	[PhoneNumber] [varchar](20) NULL,
	[Email] [varchar](200) NOT NULL,
	[FileId] [int] NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaCommerces] PRIMARY KEY CLUSTERED 
(
	[CommerceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerceSettlement]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerceSettlement](
	[CommerceSettlementId] [int] NOT NULL,
	[settlementPeriodStart] [datetime] NOT NULL,
	[settlementPeriodEnd] [datetime] NOT NULL,
	[totalGross] [decimal](18, 2) NOT NULL,
	[totalCommission] [decimal](18, 2) NOT NULL,
	[totalNet] [decimal](18, 2) NOT NULL,
	[settlementDate] [datetime] NULL,
	[status] [varchar](20) NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
	[CommerceId] [int] NOT NULL,
	[TaxRateId] [int] NOT NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[IncludesTax] [bit] NOT NULL,
 CONSTRAINT [PK_SocaiCommerceSettlement] PRIMARY KEY CLUSTERED 
(
	[CommerceSettlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerceSettlementDetail]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerceSettlementDetail](
	[CommerceSettlementDetailId] [int] IDENTITY(1,1) NOT NULL,
	[grossAmount] [decimal](18, 2) NOT NULL,
	[commission] [decimal](18, 2) NOT NULL,
	[Termsandconditions] [varchar](max) NOT NULL,
	[netAmount] [decimal](18, 2) NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
	[CommerceSettlementId] [int] NOT NULL,
	[TransactionId] [int] NOT NULL,
	[TaxRateId] [int] NOT NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[IncludesTax] [bit] NULL,
 CONSTRAINT [PK_SocaiCommerceSettlementDetail] PRIMARY KEY CLUSTERED 
(
	[CommerceSettlementDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommercesFeatures]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommercesFeatures](
	[CommercesFeaturesId] [int] IDENTITY(1,1) NOT NULL,
	[CommercesId] [int] NOT NULL,
	[PlanFeaturesId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ValidFrom] [datetime] NOT NULL,
	[ValidTo] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[OriginalPrice] [decimal](18, 2) NOT NULL,
	[NegotiatedPrice] [decimal](18, 2) NOT NULL,
	[ServiceTypeId] [int] NOT NULL,
	[IsGuaranteedRight] [bit] NOT NULL,
	[DiscountType] [char](1) NOT NULL,
	[DiscountValue] [decimal](18, 2) NOT NULL,
	[SolturaMargin] [decimal](18, 2) NOT NULL,
	[IsMarginPercentage] [bit] NOT NULL,
	[InlcudesTax] [bit] NOT NULL,
	[TaxRateId] [int] NOT NULL,
	[MinQuantity] [decimal](18, 2) NULL,
	[MaxQuantity] [decimal](18, 2) NULL,
	[TermsAndConditions] [varchar](500) NULL,
	[AdditionalBenefits] [varchar](500) NULL,
	[IsCombined] [bit] NOT NULL,
	[ContractCommercesId] [int] NOT NULL,
 CONSTRAINT [PK_CommercesFeatures] PRIMARY KEY CLUSTERED 
(
	[CommercesFeaturesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiContractCommerces]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiContractCommerces](
	[ContractCommercesId] [int] IDENTITY(1,1) NOT NULL,
	[validFrom] [datetime] NOT NULL,
	[validTo] [datetime] NULL,
	[contractType] [varchar](50) NULL,
	[contractDescription] [varchar](150) NULL,
	[isActive] [bit] NOT NULL,
	[CommerceId] [int] NOT NULL,
	[inChargeSignature] [varchar](100) NOT NULL,
	[FileId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_solturaContractCommerces] PRIMARY KEY CLUSTERED 
(
	[ContractCommercesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCountries]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCountries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_SocaiCountries] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCurrencyExchange]    Script Date: 6/5/2025 19:40:56 ******/
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
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiCurrencyExchange] PRIMARY KEY CLUSTERED 
(
	[CurrencyExchangeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCurrencyTypes]    Script Date: 6/5/2025 19:40:56 ******/
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
/****** Object:  Table [dbo].[SocaiDataPayments]    Script Date: 6/5/2025 19:40:56 ******/
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
	[UserId] [int] NULL,
	[PaymentMethodId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiDataPayments] PRIMARY KEY CLUSTERED 
(
	[DataPaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiFeaturesSubscriptions]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiFeaturesSubscriptions](
	[FeaturesSubscriptionsId] [int] IDENTITY(1,1) NOT NULL,
	[PlanFeatureId] [int] NOT NULL,
	[SubscriptionId] [int] NOT NULL,
	[Quantity] [decimal](18, 2) NULL,
	[UnitTypeId] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[ServiceTypeId] [int] NOT NULL,
	[MemberCount] [int] NOT NULL,
	[IsMemberSpecific] [bit] NOT NULL,
 CONSTRAINT [PK_featuresSubscriptions] PRIMARY KEY CLUSTERED 
(
	[FeaturesSubscriptionsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiFiles]    Script Date: 6/5/2025 19:40:56 ******/
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
	[UserId] [int] NULL,
	[FileTypeId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiFiles] PRIMARY KEY CLUSTERED 
(
	[FileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiFileTypes]    Script Date: 6/5/2025 19:40:56 ******/
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
/****** Object:  Table [dbo].[SocaiLogs]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiLogs](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[description] [varchar](255) NULL,
	[postTime] [datetime] NULL,
	[computer] [varchar](100) NULL,
	[username] [varchar](100) NULL,
	[trace] [varchar](255) NULL,
	[referenceID1] [bigint] NULL,
	[referenceID2] [bigint] NULL,
	[value1] [varchar](100) NULL,
	[value2] [varchar](100) NULL,
	[checksum] [varbinary](255) NULL,
	[lastUpdate] [datetime] NULL,
	[LogTypeId] [int] NOT NULL,
	[LogSourceId] [int] NOT NULL,
	[LogSeverityId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[TransactionId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiLogs] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiLogSeverities]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiLogSeverities](
	[LogSeverityId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](40) NULL,
	[lastUpdate] [datetime] NULL,
 CONSTRAINT [PK_SocaiLogSeverities] PRIMARY KEY CLUSTERED 
(
	[LogSeverityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiLogSources]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiLogSources](
	[LogSourceId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](40) NULL,
 CONSTRAINT [PK_SocaiLogSources] PRIMARY KEY CLUSTERED 
(
	[LogSourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiLogTypes]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiLogTypes](
	[LogTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](40) NULL,
 CONSTRAINT [PK_SocaiLogTypes] PRIMARY KEY CLUSTERED 
(
	[LogTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiPaymentMethods]    Script Date: 6/5/2025 19:40:56 ******/
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
/****** Object:  Table [dbo].[SocaiPayments]    Script Date: 6/5/2025 19:40:56 ******/
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
	[chargeToken] [varbinary](250) NOT NULL,
	[date] [datetime] NULL,
	[checksum] [varbinary](250) NOT NULL,
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
/****** Object:  Table [dbo].[SocaiPermissions]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiPermissions](
	[PermissionID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](25) NOT NULL,
	[Description] [varchar](125) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_SolturaPermisions] PRIMARY KEY CLUSTERED 
(
	[PermissionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiPlanFeatures]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiPlanFeatures](
	[FeatureId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](250) NULL,
	[Category] [varchar](50) NULL,
	[UnitTypeId] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaPlanFeatures] PRIMARY KEY CLUSTERED 
(
	[FeatureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiProvinces]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiProvinces](
	[ProvinciasId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Createdate] [datetime] NOT NULL,
	[Updatedate] [datetime] NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_solturaProvinces] PRIMARY KEY CLUSTERED 
(
	[ProvinciasId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiRenewals]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiRenewals](
	[RenewalId] [int] IDENTITY(1,1) NOT NULL,
	[renewalDate] [datetime] NOT NULL,
	[renewalMotive] [varchar](500) NOT NULL,
	[ContractCommercesId] [int] NOT NULL,
 CONSTRAINT [PK_solturaRenewals] PRIMARY KEY CLUSTERED 
(
	[RenewalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiResultPayment]    Script Date: 6/5/2025 19:40:56 ******/
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
/****** Object:  Table [dbo].[SocaiRolePermissions]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiRolePermissions](
	[RolePermissionId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[PermissionID] [int] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaRolePermissions] PRIMARY KEY CLUSTERED 
(
	[RolePermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiRoles]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiRoles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](25) NOT NULL,
	[Description] [varchar](125) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaRoles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiScheduleDetails]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiScheduleDetails](
	[ScheduleDetailId] [int] IDENTITY(1,1) NOT NULL,
	[baseDate] [datetime] NOT NULL,
	[nextExecution] [datetime] NULL,
	[lastExecution] [datetime] NULL,
	[executionStatus] [bit] NOT NULL,
	[attemptCount] [int] NULL,
	[ScheduleId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiScheduleDetails] PRIMARY KEY CLUSTERED 
(
	[ScheduleDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiSchedules]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiSchedules](
	[ScheduleId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](40) NULL,
	[recurrenceType] [varchar](20) NULL,
	[paymentDay] [tinyint] NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_SocaiSchedules] PRIMARY KEY CLUSTERED 
(
	[ScheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiServiceTypes]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiServiceTypes](
	[ServiceTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Description] [varchar](300) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_SocaiServiceTypes] PRIMARY KEY CLUSTERED 
(
	[ServiceTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiSubscriptionMembers]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiSubscriptionMembers](
	[SubscriptionMemberId] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionUserId] [int] NOT NULL,
	[Name] [varchar](40) NOT NULL,
	[Email] [varchar](60) NULL,
	[PhoneNumber] [varchar](20) NULL,
	[Relationship] [varchar](20) NULL,
	[DateofBirth] [date] NULL,
	[IsActive] [bit] NOT NULL,
	[ValidationId] [int] NOT NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK_SocaiSubscriptionMembers] PRIMARY KEY CLUSTERED 
(
	[SubscriptionMemberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiSubscriptions]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiSubscriptions](
	[SubscriptionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](250) NULL,
	[isCustomizable] [bit] NOT NULL,
	[isActive] [bit] NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NOT NULL,
	[amount] [decimal](15, 2) NOT NULL,
	[CurrencyTypeId] [int] NOT NULL,
 CONSTRAINT [PK_solturaSubscriptions] PRIMARY KEY CLUSTERED 
(
	[SubscriptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiSubscriptionSchedules]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiSubscriptionSchedules](
	[SubscriptionScheduleId] [int] IDENTITY(1,1) NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
	[status] [bit] NULL,
	[effectiveStartDate] [datetime] NOT NULL,
	[effectiveEndDate] [datetime] NOT NULL,
	[ScheduleId] [int] NOT NULL,
	[SubscriptionUserId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiSuscriptionSchedules] PRIMARY KEY CLUSTERED 
(
	[SubscriptionScheduleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiSubscriptionUser]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiSubscriptionUser](
	[SubscriptionUserId] [int] IDENTITY(1,1) NOT NULL,
	[enable] [bit] NOT NULL,
	[startDateTime] [datetime] NULL,
	[endDateTime] [datetime] NULL,
	[UserId] [int] NOT NULL,
	[SubscriptionId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiSubscriptionUser] PRIMARY KEY CLUSTERED 
(
	[SubscriptionUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiTaxRates]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiTaxRates](
	[TaxRateId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Rate] [decimal](5, 2) NOT NULL,
	[CountryId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ValidFrom] [datetime] NOT NULL,
	[ValidTo] [datetime] NULL,
 CONSTRAINT [PK_SocaiTaxRates] PRIMARY KEY CLUSTERED 
(
	[TaxRateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiTransactions]    Script Date: 6/5/2025 19:40:56 ******/
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
	[ExchangeRateId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiTransactions] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiTransactionSubTypes]    Script Date: 6/5/2025 19:40:56 ******/
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
/****** Object:  Table [dbo].[SocaiTransactionTypes]    Script Date: 6/5/2025 19:40:56 ******/
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
/****** Object:  Table [dbo].[SocaiUnitTypes]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiUnitTypes](
	[UnitTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](40) NOT NULL,
	[Symbol] [varchar](10) NULL,
	[Description] [varchar](200) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_SocaiUnitTypes] PRIMARY KEY CLUSTERED 
(
	[UnitTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiUserRoles]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiUserRoles](
	[UserRoleId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_userRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiUsers]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiUsers](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NULL,
	[Email] [varchar](220) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Password] [varbinary](100) NOT NULL,
	[AddressId] [int] NULL,
	[isActive] [bit] NOT NULL,
	[LastLogin] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaUsers] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiValidationQR]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiValidationQR](
	[ValidationId] [int] NOT NULL,
	[validationDate] [datetime] NOT NULL,
	[quantityUsed] [decimal](10, 2) NOT NULL,
	[appliedFromPlan] [decimal](10, 2) NOT NULL,
	[extraChange] [decimal](10, 2) NOT NULL,
	[ValidationStatusId] [int] NOT NULL,
	[qrCodeData] [varchar](100) NOT NULL,
	[comments] [varchar](200) NULL,
	[createdAt] [datetime] NULL,
	[updatedAt] [datetime] NULL,
	[SubscriptionUserId] [int] NOT NULL,
	[CommerceId] [int] NOT NULL,
	[FeaturesSubscriptionId] [int] NOT NULL,
	[ValidationTypeId] [int] NOT NULL,
	[TransactionId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiValidationQR] PRIMARY KEY CLUSTERED 
(
	[ValidationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiValidationTypes]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiValidationTypes](
	[ValidationTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](60) NOT NULL,
	[Description] [varchar](300) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_SocaiValidationTypes] PRIMARY KEY CLUSTERED 
(
	[ValidationTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaContractObligations]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaContractObligations](
	[ObligationsId] [int] IDENTITY(1,1) NOT NULL,
	[amountToPay] [decimal](15, 2) NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[startdate] [datetime] NOT NULL,
	[limitdate] [datetime] NOT NULL,
	[ContractCommercesID] [int] NOT NULL,
 CONSTRAINT [PK_solturaContractObligations] PRIMARY KEY CLUSTERED 
(
	[ObligationsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SocaiBalancePerPerson] ADD  CONSTRAINT [DF_SocaiBalancePerPerson_currentBalance]  DEFAULT ((0)) FOR [currentBalance]
GO
ALTER TABLE [dbo].[SocaiBalances] ADD  CONSTRAINT [DF_SocaiBalances_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[SocaiCommerceBalance] ADD  CONSTRAINT [DF_SocaiCommerceBalance_currentBalance]  DEFAULT ((0)) FOR [currentBalance]
GO
ALTER TABLE [dbo].[SocaiCommerceBalance] ADD  CONSTRAINT [DF_SocaiCommerceBalance_updatedAt]  DEFAULT (getdate()) FOR [updatedAt]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlement] ADD  CONSTRAINT [DF_SocaiCommerceSettlement_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlement] ADD  CONSTRAINT [DF_SocaiCommerceSettlement_IncludesTax]  DEFAULT ((1)) FOR [IncludesTax]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail] ADD  CONSTRAINT [DF_SocaiCommerceSettlementDetail_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail] ADD  CONSTRAINT [DF_SocaiCommerceSettlementDetail_IncludesTax]  DEFAULT ((1)) FOR [IncludesTax]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] ADD  CONSTRAINT [DF_SocaiCommercesFeatures_IsGuaranteedRight]  DEFAULT ((1)) FOR [IsGuaranteedRight]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] ADD  CONSTRAINT [DF_SocaiCommercesFeatures_IsMarginPercentage]  DEFAULT ((1)) FOR [IsMarginPercentage]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] ADD  CONSTRAINT [DF_SocaiCommercesFeatures_InlcudesTax]  DEFAULT ((1)) FOR [InlcudesTax]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] ADD  CONSTRAINT [DF_SocaiCommercesFeatures_IsCombined]  DEFAULT ((0)) FOR [IsCombined]
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions] ADD  CONSTRAINT [DF_SocaiFeaturesSubscriptions_IsMemberSpecific]  DEFAULT ((0)) FOR [IsMemberSpecific]
GO
ALTER TABLE [dbo].[SocaiFileTypes] ADD  CONSTRAINT [DF_SocaiFileTypes_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[SocaiScheduleDetails] ADD  CONSTRAINT [DF_SocaiScheduleDetails_attemptCount]  DEFAULT ((0)) FOR [attemptCount]
GO
ALTER TABLE [dbo].[SocaiSubscriptionMembers] ADD  CONSTRAINT [DF_SocaiSubscriptionMembers_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SocaiTaxRates] ADD  CONSTRAINT [DF_SocaiTaxRates_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SocaiUnitTypes] ADD  CONSTRAINT [DF_SocaiUnitTypes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SocaiValidationQR] ADD  CONSTRAINT [DF_SocaiValidationQR_validationDate]  DEFAULT (getdate()) FOR [validationDate]
GO
ALTER TABLE [dbo].[SocaiValidationTypes] ADD  CONSTRAINT [DF_SocaiValidationTypes_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SocaiAdresses]  WITH CHECK ADD  CONSTRAINT [FK_solturaAdresses_solturaCities] FOREIGN KEY([CityId])
REFERENCES [dbo].[SocaiCities] ([CityID])
GO
ALTER TABLE [dbo].[SocaiAdresses] CHECK CONSTRAINT [FK_solturaAdresses_solturaCities]
GO
ALTER TABLE [dbo].[SocaiBalancePerPerson]  WITH CHECK ADD  CONSTRAINT [BalanceId] FOREIGN KEY([BalanceId])
REFERENCES [dbo].[SocaiBalances] ([BalanceId])
GO
ALTER TABLE [dbo].[SocaiBalancePerPerson] CHECK CONSTRAINT [BalanceId]
GO
ALTER TABLE [dbo].[SocaiBalancePerPerson]  WITH CHECK ADD  CONSTRAINT [SubscriptionUserId] FOREIGN KEY([SuscriptionUserId])
REFERENCES [dbo].[SocaiSubscriptionUser] ([SubscriptionUserId])
GO
ALTER TABLE [dbo].[SocaiBalancePerPerson] CHECK CONSTRAINT [SubscriptionUserId]
GO
ALTER TABLE [dbo].[SocaiBalances]  WITH CHECK ADD  CONSTRAINT [BalanceTypeIdFK] FOREIGN KEY([BalanceTypeId])
REFERENCES [dbo].[SocaiBalanceTypes] ([BalanceTypeId])
GO
ALTER TABLE [dbo].[SocaiBalances] CHECK CONSTRAINT [BalanceTypeIdFK]
GO
ALTER TABLE [dbo].[SocaiBalances]  WITH CHECK ADD  CONSTRAINT [CurrencyTypeIdFK2] FOREIGN KEY([CurrencyTypeId])
REFERENCES [dbo].[SocaiCurrencyTypes] ([CurrencyTypeId])
GO
ALTER TABLE [dbo].[SocaiBalances] CHECK CONSTRAINT [CurrencyTypeIdFK2]
GO
ALTER TABLE [dbo].[SocaiBalances]  WITH CHECK ADD  CONSTRAINT [FeaturesSubscriptionsId4] FOREIGN KEY([FeaturesSubscriptionsId])
REFERENCES [dbo].[SocaiFeaturesSubscriptions] ([FeaturesSubscriptionsId])
GO
ALTER TABLE [dbo].[SocaiBalances] CHECK CONSTRAINT [FeaturesSubscriptionsId4]
GO
ALTER TABLE [dbo].[SocaiBalances]  WITH CHECK ADD  CONSTRAINT [SubscriptionUserId3] FOREIGN KEY([SubscriptionUserId])
REFERENCES [dbo].[SocaiSubscriptionUser] ([SubscriptionUserId])
GO
ALTER TABLE [dbo].[SocaiBalances] CHECK CONSTRAINT [SubscriptionUserId3]
GO
ALTER TABLE [dbo].[SocaiBalances]  WITH CHECK ADD  CONSTRAINT [TransactionIdFK3] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[SocaiTransactions] ([TransactionId])
GO
ALTER TABLE [dbo].[SocaiBalances] CHECK CONSTRAINT [TransactionIdFK3]
GO
ALTER TABLE [dbo].[SocaiCities]  WITH CHECK ADD  CONSTRAINT [FK_solturaCities_solturaProvinces] FOREIGN KEY([ProvinciasId])
REFERENCES [dbo].[SocaiProvinces] ([ProvinciasId])
GO
ALTER TABLE [dbo].[SocaiCities] CHECK CONSTRAINT [FK_solturaCities_solturaProvinces]
GO
ALTER TABLE [dbo].[SocaiCommerceBalance]  WITH CHECK ADD  CONSTRAINT [CommerceId] FOREIGN KEY([CommerceId])
REFERENCES [dbo].[SocaiCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[SocaiCommerceBalance] CHECK CONSTRAINT [CommerceId]
GO
ALTER TABLE [dbo].[SocaiCommerceContactPerson]  WITH CHECK ADD  CONSTRAINT [CommerceId2] FOREIGN KEY([CommerceId])
REFERENCES [dbo].[SocaiCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[SocaiCommerceContactPerson] CHECK CONSTRAINT [CommerceId2]
GO
ALTER TABLE [dbo].[SocaiCommerces]  WITH CHECK ADD  CONSTRAINT [FileIDFK] FOREIGN KEY([FileId])
REFERENCES [dbo].[SocaiFiles] ([FileId])
GO
ALTER TABLE [dbo].[SocaiCommerces] CHECK CONSTRAINT [FileIDFK]
GO
ALTER TABLE [dbo].[SocaiCommerces]  WITH CHECK ADD  CONSTRAINT [FK_solturaCommerces_solturaAdresses] FOREIGN KEY([AddressId])
REFERENCES [dbo].[SocaiAdresses] ([AddressId])
GO
ALTER TABLE [dbo].[SocaiCommerces] CHECK CONSTRAINT [FK_solturaCommerces_solturaAdresses]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlement]  WITH CHECK ADD  CONSTRAINT [CommerceIdFK1] FOREIGN KEY([CommerceId])
REFERENCES [dbo].[SocaiCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[SocaiCommerceSettlement] CHECK CONSTRAINT [CommerceIdFK1]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlement]  WITH CHECK ADD  CONSTRAINT [TaxRateId2] FOREIGN KEY([TaxRateId])
REFERENCES [dbo].[SocaiTaxRates] ([TaxRateId])
GO
ALTER TABLE [dbo].[SocaiCommerceSettlement] CHECK CONSTRAINT [TaxRateId2]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail]  WITH CHECK ADD  CONSTRAINT [FK_SocaiCommerceSettlementDetail_SocaiCommerceSettlement] FOREIGN KEY([CommerceSettlementId])
REFERENCES [dbo].[SocaiCommerceSettlement] ([CommerceSettlementId])
GO
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail] CHECK CONSTRAINT [FK_SocaiCommerceSettlementDetail_SocaiCommerceSettlement]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail]  WITH CHECK ADD  CONSTRAINT [FK_SocaiCommerceSettlementDetail_SocaiTransactions] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[SocaiTransactions] ([TransactionId])
GO
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail] CHECK CONSTRAINT [FK_SocaiCommerceSettlementDetail_SocaiTransactions]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures]  WITH CHECK ADD  CONSTRAINT [ContractCommercesId] FOREIGN KEY([ContractCommercesId])
REFERENCES [dbo].[SocaiContractCommerces] ([ContractCommercesId])
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] CHECK CONSTRAINT [ContractCommercesId]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures]  WITH CHECK ADD  CONSTRAINT [FK_CommercesFeatures_solturaCommerces] FOREIGN KEY([CommercesId])
REFERENCES [dbo].[SocaiCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] CHECK CONSTRAINT [FK_CommercesFeatures_solturaCommerces]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures]  WITH CHECK ADD  CONSTRAINT [FK_CommercesFeatures_solturaPlanFeatures] FOREIGN KEY([PlanFeaturesId])
REFERENCES [dbo].[SocaiPlanFeatures] ([FeatureId])
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] CHECK CONSTRAINT [FK_CommercesFeatures_solturaPlanFeatures]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures]  WITH CHECK ADD  CONSTRAINT [ServiceTypeId] FOREIGN KEY([ServiceTypeId])
REFERENCES [dbo].[SocaiServiceTypes] ([ServiceTypeId])
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] CHECK CONSTRAINT [ServiceTypeId]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures]  WITH CHECK ADD  CONSTRAINT [TaxRateId] FOREIGN KEY([TaxRateId])
REFERENCES [dbo].[SocaiTaxRates] ([TaxRateId])
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] CHECK CONSTRAINT [TaxRateId]
GO
ALTER TABLE [dbo].[SocaiContractCommerces]  WITH CHECK ADD  CONSTRAINT [CommerceIdFK] FOREIGN KEY([CommerceId])
REFERENCES [dbo].[SocaiCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[SocaiContractCommerces] CHECK CONSTRAINT [CommerceIdFK]
GO
ALTER TABLE [dbo].[SocaiContractCommerces]  WITH CHECK ADD  CONSTRAINT [FileIdFK3] FOREIGN KEY([FileId])
REFERENCES [dbo].[SocaiFiles] ([FileId])
GO
ALTER TABLE [dbo].[SocaiContractCommerces] CHECK CONSTRAINT [FileIdFK3]
GO
ALTER TABLE [dbo].[SocaiContractCommerces]  WITH CHECK ADD  CONSTRAINT [FK_SocaiContractCommerces_SocaiCountries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[SocaiCountries] ([CountryId])
GO
ALTER TABLE [dbo].[SocaiContractCommerces] CHECK CONSTRAINT [FK_SocaiContractCommerces_SocaiCountries]
GO
ALTER TABLE [dbo].[SocaiCurrencyExchange]  WITH CHECK ADD  CONSTRAINT [CountryId3] FOREIGN KEY([CountryId])
REFERENCES [dbo].[SocaiCountries] ([CountryId])
GO
ALTER TABLE [dbo].[SocaiCurrencyExchange] CHECK CONSTRAINT [CountryId3]
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
ALTER TABLE [dbo].[SocaiDataPayments]  WITH CHECK ADD  CONSTRAINT [PaymentMethodId] FOREIGN KEY([PaymentMethodId])
REFERENCES [dbo].[SocaiPaymentMethods] ([PaymentMethodId])
GO
ALTER TABLE [dbo].[SocaiDataPayments] CHECK CONSTRAINT [PaymentMethodId]
GO
ALTER TABLE [dbo].[SocaiDataPayments]  WITH CHECK ADD  CONSTRAINT [UserIdFK] FOREIGN KEY([UserId])
REFERENCES [dbo].[SocaiUsers] ([UserId])
GO
ALTER TABLE [dbo].[SocaiDataPayments] CHECK CONSTRAINT [UserIdFK]
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions]  WITH CHECK ADD  CONSTRAINT [FK_featuresSubscriptions_solturaPlanFeatures] FOREIGN KEY([PlanFeatureId])
REFERENCES [dbo].[SocaiPlanFeatures] ([FeatureId])
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions] CHECK CONSTRAINT [FK_featuresSubscriptions_solturaPlanFeatures]
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions]  WITH CHECK ADD  CONSTRAINT [ServiceTypeId2] FOREIGN KEY([ServiceTypeId])
REFERENCES [dbo].[SocaiServiceTypes] ([ServiceTypeId])
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions] CHECK CONSTRAINT [ServiceTypeId2]
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions]  WITH CHECK ADD  CONSTRAINT [SuscriptionIdFK] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[SocaiSubscriptions] ([SubscriptionId])
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions] CHECK CONSTRAINT [SuscriptionIdFK]
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions]  WITH CHECK ADD  CONSTRAINT [UnitTypeId2] FOREIGN KEY([UnitTypeId])
REFERENCES [dbo].[SocaiUnitTypes] ([UnitTypeId])
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions] CHECK CONSTRAINT [UnitTypeId2]
GO
ALTER TABLE [dbo].[SocaiFiles]  WITH CHECK ADD  CONSTRAINT [FileTypeIdFK] FOREIGN KEY([FileTypeId])
REFERENCES [dbo].[SocaiFileTypes] ([FileTypeId])
GO
ALTER TABLE [dbo].[SocaiFiles] CHECK CONSTRAINT [FileTypeIdFK]
GO
ALTER TABLE [dbo].[SocaiFiles]  WITH CHECK ADD  CONSTRAINT [UserIdFK3] FOREIGN KEY([UserId])
REFERENCES [dbo].[SocaiUsers] ([UserId])
GO
ALTER TABLE [dbo].[SocaiFiles] CHECK CONSTRAINT [UserIdFK3]
GO
ALTER TABLE [dbo].[SocaiLogs]  WITH CHECK ADD  CONSTRAINT [LogSeverityIdFK] FOREIGN KEY([LogSeverityId])
REFERENCES [dbo].[SocaiLogSeverities] ([LogSeverityId])
GO
ALTER TABLE [dbo].[SocaiLogs] CHECK CONSTRAINT [LogSeverityIdFK]
GO
ALTER TABLE [dbo].[SocaiLogs]  WITH CHECK ADD  CONSTRAINT [LogSourceIdFK] FOREIGN KEY([LogSourceId])
REFERENCES [dbo].[SocaiLogSources] ([LogSourceId])
GO
ALTER TABLE [dbo].[SocaiLogs] CHECK CONSTRAINT [LogSourceIdFK]
GO
ALTER TABLE [dbo].[SocaiLogs]  WITH CHECK ADD  CONSTRAINT [LogTypeIdFK] FOREIGN KEY([LogTypeId])
REFERENCES [dbo].[SocaiLogTypes] ([LogTypeId])
GO
ALTER TABLE [dbo].[SocaiLogs] CHECK CONSTRAINT [LogTypeIdFK]
GO
ALTER TABLE [dbo].[SocaiLogs]  WITH CHECK ADD  CONSTRAINT [TransactionIdFK1] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[SocaiTransactions] ([TransactionId])
GO
ALTER TABLE [dbo].[SocaiLogs] CHECK CONSTRAINT [TransactionIdFK1]
GO
ALTER TABLE [dbo].[SocaiLogs]  WITH CHECK ADD  CONSTRAINT [UserIdFK2] FOREIGN KEY([UserId])
REFERENCES [dbo].[SocaiUsers] ([UserId])
GO
ALTER TABLE [dbo].[SocaiLogs] CHECK CONSTRAINT [UserIdFK2]
GO
ALTER TABLE [dbo].[SocaiPayments]  WITH CHECK ADD  CONSTRAINT [CurrencyTypesId] FOREIGN KEY([CurrencyTypeId])
REFERENCES [dbo].[SocaiCurrencyTypes] ([CurrencyTypeId])
GO
ALTER TABLE [dbo].[SocaiPayments] CHECK CONSTRAINT [CurrencyTypesId]
GO
ALTER TABLE [dbo].[SocaiPayments]  WITH CHECK ADD  CONSTRAINT [FK_SocaiPayments_SocaiUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[SocaiUsers] ([UserId])
GO
ALTER TABLE [dbo].[SocaiPayments] CHECK CONSTRAINT [FK_SocaiPayments_SocaiUsers]
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
ALTER TABLE [dbo].[SocaiPlanFeatures]  WITH CHECK ADD  CONSTRAINT [UnitTypeId] FOREIGN KEY([UnitTypeId])
REFERENCES [dbo].[SocaiUnitTypes] ([UnitTypeId])
GO
ALTER TABLE [dbo].[SocaiPlanFeatures] CHECK CONSTRAINT [UnitTypeId]
GO
ALTER TABLE [dbo].[SocaiProvinces]  WITH CHECK ADD  CONSTRAINT [CountryId] FOREIGN KEY([CountryId])
REFERENCES [dbo].[SocaiCountries] ([CountryId])
GO
ALTER TABLE [dbo].[SocaiProvinces] CHECK CONSTRAINT [CountryId]
GO
ALTER TABLE [dbo].[SocaiRenewals]  WITH CHECK ADD  CONSTRAINT [FK_solturaRenewals_solturaContractCommerces] FOREIGN KEY([ContractCommercesId])
REFERENCES [dbo].[SocaiContractCommerces] ([ContractCommercesId])
GO
ALTER TABLE [dbo].[SocaiRenewals] CHECK CONSTRAINT [FK_solturaRenewals_solturaContractCommerces]
GO
ALTER TABLE [dbo].[SocaiRolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_solturaRolePermissions_SolturaPermisions] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[SocaiPermissions] ([PermissionID])
GO
ALTER TABLE [dbo].[SocaiRolePermissions] CHECK CONSTRAINT [FK_solturaRolePermissions_SolturaPermisions]
GO
ALTER TABLE [dbo].[SocaiRolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_solturaRolePermissions_solturaRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[SocaiRoles] ([RoleId])
GO
ALTER TABLE [dbo].[SocaiRolePermissions] CHECK CONSTRAINT [FK_solturaRolePermissions_solturaRoles]
GO
ALTER TABLE [dbo].[SocaiScheduleDetails]  WITH CHECK ADD  CONSTRAINT [ScheduleIdFK] FOREIGN KEY([ScheduleId])
REFERENCES [dbo].[SocaiSchedules] ([ScheduleId])
GO
ALTER TABLE [dbo].[SocaiScheduleDetails] CHECK CONSTRAINT [ScheduleIdFK]
GO
ALTER TABLE [dbo].[SocaiSubscriptionMembers]  WITH CHECK ADD  CONSTRAINT [SubscriptionUserId2] FOREIGN KEY([SubscriptionUserId])
REFERENCES [dbo].[SocaiSubscriptionUser] ([SubscriptionUserId])
GO
ALTER TABLE [dbo].[SocaiSubscriptionMembers] CHECK CONSTRAINT [SubscriptionUserId2]
GO
ALTER TABLE [dbo].[SocaiSubscriptionMembers]  WITH CHECK ADD  CONSTRAINT [ValidationQrId] FOREIGN KEY([ValidationId])
REFERENCES [dbo].[SocaiValidationQR] ([ValidationId])
GO
ALTER TABLE [dbo].[SocaiSubscriptionMembers] CHECK CONSTRAINT [ValidationQrId]
GO
ALTER TABLE [dbo].[SocaiSubscriptions]  WITH CHECK ADD  CONSTRAINT [CurrencyTypeId] FOREIGN KEY([CurrencyTypeId])
REFERENCES [dbo].[SocaiCurrencyTypes] ([CurrencyTypeId])
GO
ALTER TABLE [dbo].[SocaiSubscriptions] CHECK CONSTRAINT [CurrencyTypeId]
GO
ALTER TABLE [dbo].[SocaiSubscriptionSchedules]  WITH CHECK ADD  CONSTRAINT [ScheduleIdFK1] FOREIGN KEY([ScheduleId])
REFERENCES [dbo].[SocaiSchedules] ([ScheduleId])
GO
ALTER TABLE [dbo].[SocaiSubscriptionSchedules] CHECK CONSTRAINT [ScheduleIdFK1]
GO
ALTER TABLE [dbo].[SocaiSubscriptionSchedules]  WITH CHECK ADD  CONSTRAINT [SubscriptionUserFK] FOREIGN KEY([SubscriptionUserId])
REFERENCES [dbo].[SocaiSubscriptionUser] ([SubscriptionUserId])
GO
ALTER TABLE [dbo].[SocaiSubscriptionSchedules] CHECK CONSTRAINT [SubscriptionUserFK]
GO
ALTER TABLE [dbo].[SocaiSubscriptionUser]  WITH CHECK ADD  CONSTRAINT [SubscriptionIdFK] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[SocaiSubscriptions] ([SubscriptionId])
GO
ALTER TABLE [dbo].[SocaiSubscriptionUser] CHECK CONSTRAINT [SubscriptionIdFK]
GO
ALTER TABLE [dbo].[SocaiSubscriptionUser]  WITH CHECK ADD  CONSTRAINT [UserIdFK4] FOREIGN KEY([UserId])
REFERENCES [dbo].[SocaiUsers] ([UserId])
GO
ALTER TABLE [dbo].[SocaiSubscriptionUser] CHECK CONSTRAINT [UserIdFK4]
GO
ALTER TABLE [dbo].[SocaiTaxRates]  WITH CHECK ADD  CONSTRAINT [CountryId2] FOREIGN KEY([CountryId])
REFERENCES [dbo].[SocaiCountries] ([CountryId])
GO
ALTER TABLE [dbo].[SocaiTaxRates] CHECK CONSTRAINT [CountryId2]
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
ALTER TABLE [dbo].[SocaiTransactions]  WITH CHECK ADD  CONSTRAINT [UserIdsFK] FOREIGN KEY([UserId])
REFERENCES [dbo].[SocaiUsers] ([UserId])
GO
ALTER TABLE [dbo].[SocaiTransactions] CHECK CONSTRAINT [UserIdsFK]
GO
ALTER TABLE [dbo].[SocaiUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_userRoles_solturaRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[SocaiRoles] ([RoleId])
GO
ALTER TABLE [dbo].[SocaiUserRoles] CHECK CONSTRAINT [FK_userRoles_solturaRoles]
GO
ALTER TABLE [dbo].[SocaiUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_userRoles_solturaUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[SocaiUsers] ([UserId])
GO
ALTER TABLE [dbo].[SocaiUserRoles] CHECK CONSTRAINT [FK_userRoles_solturaUsers]
GO
ALTER TABLE [dbo].[SocaiUsers]  WITH CHECK ADD  CONSTRAINT [FK_solturaUsers_solturaAdresses] FOREIGN KEY([AddressId])
REFERENCES [dbo].[SocaiAdresses] ([AddressId])
GO
ALTER TABLE [dbo].[SocaiUsers] CHECK CONSTRAINT [FK_solturaUsers_solturaAdresses]
GO
ALTER TABLE [dbo].[SocaiValidationQR]  WITH CHECK ADD  CONSTRAINT [CommerceId4] FOREIGN KEY([CommerceId])
REFERENCES [dbo].[SocaiCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[SocaiValidationQR] CHECK CONSTRAINT [CommerceId4]
GO
ALTER TABLE [dbo].[SocaiValidationQR]  WITH CHECK ADD  CONSTRAINT [FeaturesSubscriptionId] FOREIGN KEY([FeaturesSubscriptionId])
REFERENCES [dbo].[SocaiFeaturesSubscriptions] ([FeaturesSubscriptionsId])
GO
ALTER TABLE [dbo].[SocaiValidationQR] CHECK CONSTRAINT [FeaturesSubscriptionId]
GO
ALTER TABLE [dbo].[SocaiValidationQR]  WITH CHECK ADD  CONSTRAINT [SubscriptionUserIdFK3] FOREIGN KEY([SubscriptionUserId])
REFERENCES [dbo].[SocaiSubscriptionUser] ([SubscriptionUserId])
GO
ALTER TABLE [dbo].[SocaiValidationQR] CHECK CONSTRAINT [SubscriptionUserIdFK3]
GO
ALTER TABLE [dbo].[SocaiValidationQR]  WITH CHECK ADD  CONSTRAINT [TransactionId4] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[SocaiTransactions] ([TransactionId])
GO
ALTER TABLE [dbo].[SocaiValidationQR] CHECK CONSTRAINT [TransactionId4]
GO
ALTER TABLE [dbo].[SocaiValidationQR]  WITH CHECK ADD  CONSTRAINT [ValidationTypeId] FOREIGN KEY([ValidationTypeId])
REFERENCES [dbo].[SocaiValidationTypes] ([ValidationTypeId])
GO
ALTER TABLE [dbo].[SocaiValidationQR] CHECK CONSTRAINT [ValidationTypeId]
GO
ALTER TABLE [dbo].[solturaContractObligations]  WITH CHECK ADD  CONSTRAINT [CurrencyIdFK3] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[SocaiCurrencyTypes] ([CurrencyTypeId])
GO
ALTER TABLE [dbo].[solturaContractObligations] CHECK CONSTRAINT [CurrencyIdFK3]
GO
ALTER TABLE [dbo].[solturaContractObligations]  WITH CHECK ADD  CONSTRAINT [FK_solturaContractObligations_solturaContractCommerces] FOREIGN KEY([ContractCommercesID])
REFERENCES [dbo].[SocaiContractCommerces] ([ContractCommercesId])
GO
ALTER TABLE [dbo].[solturaContractObligations] CHECK CONSTRAINT [FK_solturaContractObligations_solturaContractCommerces]
GO
/****** Object:  StoredProcedure [dbo].[FillSocaiSubscriptions]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FillSocaiSubscriptions]
AS

BEGIN
    -- Ok aqui definimos las variables para control
    DECLARE @total_active_subscriptions INT = 25;
    DECLARE @total_inactive_subscriptions INT = 5;
    DECLARE @current_plan INT = 2; -- Los planes comienzan en ID 2 debido a que cuando los generamos empezaron en 2
    DECLARE @max_plan INT = 9; -- Ultimo id son 8 planees en total
    DECLARE @subscriptions_per_plan INT;
    DECLARE @subscriptions_left INT;
    DECLARE @users_assigned TABLE (UserId INT);
    DECLARE @available_users TABLE (UserId INT);
    DECLARE @user_to_assign INT;
    DECLARE @active_user_count INT = 0;
    DECLARE @inactive_user_count INT = 0;
    DECLARE @rand_start_date DATETIME;
    DECLARE @rand_end_date DATETIME;
    
    -- Obtener todos los usuarios disponibles actualmente que son 30
    INSERT INTO @available_users (UserId)
    SELECT UserId FROM SocaiUsers ORDER BY UserId;
    
    -- Distribuimos suscripciones activas entre los planes
    -- iniciar con todos los planes teniendo 3 suscripciones
    WHILE @current_plan <= @max_plan

    BEGIN
        -- Asignar entre 3 y 6 suscripciones por plan esto para que no se acaben de un solo
        -- Pero no mas de las que quedan disponibles
        SET @subscriptions_left = @total_active_subscriptions - @active_user_count;
        
        -- Si este el ultimo plan, asignar todas las suscripciones restantes
        IF @current_plan = @max_plan AND @subscriptions_left > 0

        BEGIN
            SET @subscriptions_per_plan = @subscriptions_left;
        END

        ELSE

        BEGIN
            -- Calcular cuantas suscripciones quedan por plan
            DECLARE @remaining_plans INT = @max_plan - @current_plan + 1;
            DECLARE @min_per_remaining_plan INT = @subscriptions_left / @remaining_plans;
            
            -- Asignar entre 3 y 6, pero no menos de lo minimo necesario
            SET @subscriptions_per_plan = 
                CASE 
                    WHEN @min_per_remaining_plan <= 3 THEN 3
                    WHEN @min_per_remaining_plan >= 6 THEN 6
                    ELSE @min_per_remaining_plan
                END;
                
            -- Pero nunca mas de lo que queda disponible como tal
            IF @subscriptions_per_plan > @subscriptions_left
                SET @subscriptions_per_plan = @subscriptions_left;
        END
        
        -- Asignar suscripciones para este plan
        DECLARE @i INT = 0;
        WHILE @i < @subscriptions_per_plan
        BEGIN

            -- Seleccionar un usuario aleatorio no asignado aun
            SELECT TOP 1 @user_to_assign = UserId 
            FROM @available_users 
            ORDER BY NEWID();
            
            -- Generar fechas aleatorias para la suscripción activa
            -- Generar fechas aleatorias para la suscripción activa
            SET @rand_start_date = DATEADD(DAY, -FLOOR(RAND() * 25), GETDATE()); -- Inicio en los ultimos 30 dias
            SET @rand_end_date = DATEADD(DAY, 30, @rand_start_date); -- 30 días de suscripcion
            
            -- Insertar la suscripción activa
            INSERT INTO SocaiSubscriptionUser (enable, startDateTime, endDateTime, UserId, SubscriptionId)
            VALUES (1, @rand_start_date, @rand_end_date, @user_to_assign, @current_plan);
            
            -- Registrar el usuario como asignado
            INSERT INTO @users_assigned (UserId) VALUES (@user_to_assign);
            
            -- Eliminar el usuario de los disponibles
            DELETE FROM @available_users WHERE UserId = @user_to_assign;
            
            SET @i = @i + 1;
            SET @active_user_count = @active_user_count + 1;
        END
        
        SET @current_plan = @current_plan + 1;
    END
    
    -- Asignamos 5 suscripciones inactivas a usuarios no asignados aun
    WHILE @inactive_user_count < @total_inactive_subscriptions
    BEGIN

        -- Seleccionamos un usuario aleatorio no asignado aun
        SELECT TOP 1 @user_to_assign = UserId 
        FROM @available_users 
        ORDER BY NEWID();
        
        -- Generar fechas aleatorias para la suscripcion inactiva que existe
        SET @rand_start_date = DATEADD(DAY, -FLOOR(60 + RAND() * 30), GETDATE()); -- Inicio hace 60-90 días
        SET @rand_end_date = DATEADD(DAY, 30, @rand_start_date); --  30 dias de suscripción, ya venció
        
        -- Seleccionar un plan aleatorio
        DECLARE @random_plan INT = FLOOR(2 + RAND() * 7); -- Entre 2 y 8
        
        -- Insertar la suscripcion inactiva
        INSERT INTO SocaiSubscriptionUser (enable, startDateTime, endDateTime, UserId, SubscriptionId)
        VALUES (0, @rand_start_date, @rand_end_date, @user_to_assign, @random_plan);
        
        -- Eliminar el usuario de los disponibles
        DELETE FROM @available_users WHERE UserId = @user_to_assign;
        
        SET @inactive_user_count = @inactive_user_count + 1;
    END
    
    -- Verificación de resultados
    SELECT 'Suscripciones asignadas exitosamente: 25 activas, 5 inactivas.' AS resultado;
END;
GO
/****** Object:  StoredProcedure [dbo].[FillSocaiUsers]    Script Date: 6/5/2025 19:40:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FillSocaiUsers]
AS

BEGIN
    DECLARE @i INT = 1;
    DECLARE @total_users INT = 30;
    DECLARE @nombre VARCHAR(50);
    DECLARE @apellido VARCHAR(50);
    DECLARE @email_usuario VARCHAR(100);
    DECLARE @email_dominio VARCHAR(20);
    DECLARE @telefono VARCHAR(20);
    DECLARE @direccion_id INT;
    DECLARE @password_hash VARBINARY(100);
    
    -- Generacioon de 30 usuarios
    WHILE @i <= @total_users

    BEGIN
        -- Generar datos aleatorios para el usuario con una lista ampliada
        SET @nombre = 
            CASE FLOOR(1 + RAND() * 30)
                WHEN 1 THEN 'Ana' WHEN 2 THEN 'Carlos' WHEN 3 THEN 'Maria' 
                WHEN 4 THEN 'Jose' WHEN 5 THEN 'Priscilla' WHEN 6 THEN 'Pedro'
                WHEN 7 THEN 'Sofia' WHEN 8 THEN 'Daniel' WHEN 9 THEN 'Gabriela'
                WHEN 10 THEN 'Luis' WHEN 11 THEN 'Natalia' WHEN 12 THEN 'Roberto'
                WHEN 13 THEN 'Monica' WHEN 14 THEN 'Alberto' WHEN 15 THEN 'Karla'
                WHEN 16 THEN 'Francisco' WHEN 17 THEN 'Adriana' WHEN 18 THEN 'Ricardo'
                WHEN 19 THEN 'Valeria' WHEN 20 THEN 'Ferran' WHEN 21 THEN 'Patricia'
                WHEN 22 THEN 'Christopher' WHEN 23 THEN 'Alejandra' WHEN 24 THEN 'David'
                WHEN 25 THEN 'Carolina' WHEN 26 THEN 'Fernando' WHEN 27 THEN 'Isabel'
                WHEN 28 THEN 'Adrian' WHEN 29 THEN 'Lamine' ELSE 'Alejandro'
            END;
            
        SET @apellido = 
            CASE FLOOR(1 + RAND() * 30)
                WHEN 1 THEN 'Rodriguez' WHEN 2 THEN 'Gonzalez' WHEN 3 THEN 'Hernandez'
                WHEN 4 THEN 'Lopez' WHEN 5 THEN 'Flick' WHEN 6 THEN 'Sanchez'
                WHEN 7 THEN 'Perez' WHEN 8 THEN 'Ramirez' WHEN 9 THEN 'Torres'
                WHEN 10 THEN 'Flores' WHEN 11 THEN 'Topuria' WHEN 12 THEN 'Gomez'
                WHEN 13 THEN 'Vargas' WHEN 14 THEN 'Cruz' WHEN 15 THEN 'Jimenez'
                WHEN 16 THEN 'Morales' WHEN 17 THEN 'Reyes' WHEN 18 THEN 'Ortiz'
                WHEN 19 THEN 'Gutierrez' WHEN 20 THEN 'Castro' WHEN 21 THEN 'Vargas'
                WHEN 22 THEN 'Poirier' WHEN 23 THEN 'Alvarez' WHEN 24 THEN 'Mendoza'
                WHEN 25 THEN 'Fernandez' WHEN 26 THEN 'Ruiz' WHEN 27 THEN 'Navarro'
                WHEN 28 THEN 'Molina' WHEN 29 THEN 'Delgado' ELSE 'Aguilar'
            END;
            
        SET @email_dominio = 
            CASE FLOOR(1 + RAND() * 8)
                WHEN 1 THEN '@gmail.com' WHEN 2 THEN '@hotmail.com' WHEN 3 THEN '@yahoo.com'
                WHEN 4 THEN '@outlook.com' WHEN 5 THEN '@icloud.com' WHEN 6 THEN '@me.com'
                WHEN 7 THEN '@casamail.com' ELSE '@eslive.com'
            END;
        
        SET @email_usuario = LOWER(@nombre) + '.' + LOWER(@apellido) + 
                            CAST(FLOOR(100 + RAND() * 900) AS VARCHAR) + @email_dominio;
                            
        SET @telefono = '8' + RIGHT('000' + CAST(FLOOR(100 + RAND() * 900) AS VARCHAR), 3) + '-' + 
                       RIGHT('0000' + CAST(FLOOR(1000 + RAND() * 9000) AS VARCHAR), 4);
                       
        SET @direccion_id = @i; -- Usamos la direccion generadas de 1 - 30
        
        SET @password_hash = CAST('hash_' + CONVERT(VARCHAR(32), HASHBYTES('MD5', 
                              @nombre + @apellido + CAST(FLOOR(RAND() * 1000) AS VARCHAR)), 2) AS VARBINARY(100));
        
        -- Insertar usuario
        INSERT INTO SocaiUsers (Name, Email, PhoneNumber, Password, AddressId, isActive, LastLogin, CreatedAt)
        VALUES ( @nombre + ' ' + @apellido,  @email_usuario, @telefono, @password_hash,
            @direccion_id, 1, DATEADD(DAY, -FLOOR(RAND() * 30), GETDATE()), 
            DATEADD(DAY, -(30 + FLOOR(RAND() * 180)), GETDATE()));
        
        SET @i = @i + 1;
    END
    
END;
GO
