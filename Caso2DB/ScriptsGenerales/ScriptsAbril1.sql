USE [master]
GO
/****** Object:  Database [Caso2]    Script Date: 31/3/2025 20:14:39 ******/
CREATE DATABASE [Caso2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Caso2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Caso2.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Caso2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Caso2_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Caso2] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Caso2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Caso2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Caso2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Caso2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Caso2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Caso2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Caso2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Caso2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Caso2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Caso2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Caso2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Caso2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Caso2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Caso2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Caso2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Caso2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Caso2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Caso2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Caso2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Caso2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Caso2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Caso2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Caso2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Caso2] SET RECOVERY FULL 
GO
ALTER DATABASE [Caso2] SET  MULTI_USER 
GO
ALTER DATABASE [Caso2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Caso2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Caso2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Caso2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Caso2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Caso2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Caso2', N'ON'
GO
ALTER DATABASE [Caso2] SET QUERY_STORE = ON
GO
ALTER DATABASE [Caso2] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Caso2]
GO
/****** Object:  Table [dbo].[SocaiAdresses]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiBalancePerPerson]    Script Date: 31/3/2025 20:14:40 ******/
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
 CONSTRAINT [PK_SocaiBalancePerPerson] PRIMARY KEY CLUSTERED 
(
	[BalancePerPersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiBalances]    Script Date: 31/3/2025 20:14:40 ******/
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
 CONSTRAINT [PK_SocaiBalances] PRIMARY KEY CLUSTERED 
(
	[BalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiBalanceTypes]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiCities]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiCommerceBalance]    Script Date: 31/3/2025 20:14:40 ******/
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
	[CommerceSettlementId] [int] NULL,
 CONSTRAINT [PK_SocaiCommerceBalance] PRIMARY KEY CLUSTERED 
(
	[CommerceBalanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerces]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerces](
	[CommerceId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](225) NULL,
	[Description] [varchar](250) NULL,
	[AdressId] [int] NOT NULL,
	[PhoneNumber] [varchar](20) NULL,
	[Email] [varchar](200) NOT NULL,
	[FileId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaCommerces] PRIMARY KEY CLUSTERED 
(
	[CommerceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerceSettlement]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerceSettlement](
	[CommerceSettlementId] [int] IDENTITY(1,1) NOT NULL,
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
	[CommerceSettlementId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommerceSettlementDetail]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommerceSettlementDetail](
	[CommerceSettlementDetailId] [int] IDENTITY(1,1) NOT NULL,
	[grossAmount] [decimal](18, 2) NOT NULL,
	[commission] [decimal](18, 2) NOT NULL,
	[netAmount] [decimal](18, 2) NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NULL,
	[CommerceSettlementId] [int] NOT NULL,
	[TransactionId] [int] NOT NULL,
 CONSTRAINT [PK_SocaiCommerceSettlementDetail] PRIMARY KEY CLUSTERED 
(
	[CommerceSettlementDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCommercesFeatures]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiCommercesFeatures](
	[CommercesFeaturesId] [int] IDENTITY(1,1) NOT NULL,
	[CommercesId] [int] NOT NULL,
	[FeaturesId] [int] NOT NULL,
	[TermsAndCondtitions] [varchar](max) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[ValidFrom] [datetime] NOT NULL,
	[ValidTo] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[featurePrice] [decimal](18, 2) NULL,
 CONSTRAINT [PK_CommercesFeatures] PRIMARY KEY CLUSTERED 
(
	[CommercesFeaturesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiContractCommerces]    Script Date: 31/3/2025 20:14:40 ******/
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
	[disscountPercentage] [float] NOT NULL,
	[CommerceId] [int] NOT NULL,
	[inChargeSignature] [varchar](100) NOT NULL,
	[FileId] [int] NOT NULL,
 CONSTRAINT [PK_solturaContractCommerces] PRIMARY KEY CLUSTERED 
(
	[ContractCommercesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiCurrencyExchange]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiCurrencyTypes]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiDataPayments]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiFeaturesSubscriptions]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiFeaturesSubscriptions](
	[FeaturesSubscriptionsId] [int] IDENTITY(1,1) NOT NULL,
	[FeatureId] [int] NOT NULL,
	[SubscriptionId] [int] NOT NULL,
	[Quantity] [float] NOT NULL,
	[Unit] [varchar](100) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_featuresSubscriptions] PRIMARY KEY CLUSTERED 
(
	[FeaturesSubscriptionsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiFiles]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiFileTypes]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiLogs]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiLogSeverities]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiLogSources]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiLogTypes]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiPaymentMethods]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiPayments]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiPermisions]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiPermisions](
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
/****** Object:  Table [dbo].[SocaiPlanFeatures]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiPlanFeatures](
	[FeatureId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](250) NULL,
	[Category] [varchar](50) NULL,
	[unitType] [varchar](50) NOT NULL,
	[isActive] [bit] NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaPlanFeatures] PRIMARY KEY CLUSTERED 
(
	[FeatureId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiProvinces]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiProvinces](
	[ProvinciasId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Createdate] [datetime] NOT NULL,
	[Updatedate] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaProvinces] PRIMARY KEY CLUSTERED 
(
	[ProvinciasId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiRenewals]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiRenewals](
	[RenewalId] [int] IDENTITY(1,1) NOT NULL,
	[renewalDate] [datetime] NOT NULL,
	[renewalMotive] [varchar](250) NOT NULL,
	[ContractCommercesId] [int] NOT NULL,
 CONSTRAINT [PK_solturaRenewals] PRIMARY KEY CLUSTERED 
(
	[RenewalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiResultPayment]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiRolePermissions]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiRoles]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiScheduleDetails]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiSchedules]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiSubscriptions]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiSubscriptionUser]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiSuscriptionSchedules]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocaiSuscriptionSchedules](
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
/****** Object:  Table [dbo].[SocaiTransactions]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiTransactionSubTypes]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiTransactionTypes]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiUserRoles]    Script Date: 31/3/2025 20:14:40 ******/
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
/****** Object:  Table [dbo].[SocaiUsers]    Script Date: 31/3/2025 20:14:40 ******/
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
	[AdressId] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[LastLogin] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaUsers] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocaiValidationQR]    Script Date: 31/3/2025 20:14:40 ******/
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
 CONSTRAINT [PK_SocaiValidationQR] PRIMARY KEY CLUSTERED 
(
	[ValidationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaContractObligations]    Script Date: 31/3/2025 20:14:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaContractObligations](
	[ObligationsId] [int] NOT NULL,
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
ALTER TABLE [dbo].[SocaiCommerceSettlementDetail] ADD  CONSTRAINT [DF_SocaiCommerceSettlementDetail_createdAt]  DEFAULT (getdate()) FOR [createdAt]
GO
ALTER TABLE [dbo].[SocaiFileTypes] ADD  CONSTRAINT [DF_SocaiFileTypes_enabled]  DEFAULT ((1)) FOR [enabled]
GO
ALTER TABLE [dbo].[SocaiScheduleDetails] ADD  CONSTRAINT [DF_SocaiScheduleDetails_attemptCount]  DEFAULT ((0)) FOR [attemptCount]
GO
ALTER TABLE [dbo].[SocaiValidationQR] ADD  CONSTRAINT [DF_SocaiValidationQR_validationDate]  DEFAULT (getdate()) FOR [validationDate]
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
ALTER TABLE [dbo].[SocaiCommerceBalance]  WITH CHECK ADD  CONSTRAINT [CommerceSettlementId] FOREIGN KEY([CommerceSettlementId])
REFERENCES [dbo].[SocaiCommerceSettlement] ([CommerceSettlementId])
GO
ALTER TABLE [dbo].[SocaiCommerceBalance] CHECK CONSTRAINT [CommerceSettlementId]
GO
ALTER TABLE [dbo].[SocaiCommerces]  WITH CHECK ADD  CONSTRAINT [FileIDFK] FOREIGN KEY([FileId])
REFERENCES [dbo].[SocaiFiles] ([FileId])
GO
ALTER TABLE [dbo].[SocaiCommerces] CHECK CONSTRAINT [FileIDFK]
GO
ALTER TABLE [dbo].[SocaiCommerces]  WITH CHECK ADD  CONSTRAINT [FK_solturaCommerces_solturaAdresses] FOREIGN KEY([AdressId])
REFERENCES [dbo].[SocaiAdresses] ([AddressId])
GO
ALTER TABLE [dbo].[SocaiCommerces] CHECK CONSTRAINT [FK_solturaCommerces_solturaAdresses]
GO
ALTER TABLE [dbo].[SocaiCommerceSettlement]  WITH CHECK ADD  CONSTRAINT [CommerceIdFK1] FOREIGN KEY([CommerceId])
REFERENCES [dbo].[SocaiCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[SocaiCommerceSettlement] CHECK CONSTRAINT [CommerceIdFK1]
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
ALTER TABLE [dbo].[SocaiCommercesFeatures]  WITH CHECK ADD  CONSTRAINT [FK_CommercesFeatures_solturaCommerces] FOREIGN KEY([CommercesId])
REFERENCES [dbo].[SocaiCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] CHECK CONSTRAINT [FK_CommercesFeatures_solturaCommerces]
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures]  WITH CHECK ADD  CONSTRAINT [FK_CommercesFeatures_solturaPlanFeatures] FOREIGN KEY([FeaturesId])
REFERENCES [dbo].[SocaiPlanFeatures] ([FeatureId])
GO
ALTER TABLE [dbo].[SocaiCommercesFeatures] CHECK CONSTRAINT [FK_CommercesFeatures_solturaPlanFeatures]
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
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions]  WITH CHECK ADD  CONSTRAINT [FK_featuresSubscriptions_solturaPlanFeatures] FOREIGN KEY([FeatureId])
REFERENCES [dbo].[SocaiPlanFeatures] ([FeatureId])
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions] CHECK CONSTRAINT [FK_featuresSubscriptions_solturaPlanFeatures]
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions]  WITH CHECK ADD  CONSTRAINT [SuscriptionIdFK] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[SocaiSubscriptions] ([SubscriptionId])
GO
ALTER TABLE [dbo].[SocaiFeaturesSubscriptions] CHECK CONSTRAINT [SuscriptionIdFK]
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
ALTER TABLE [dbo].[SocaiRenewals]  WITH CHECK ADD  CONSTRAINT [FK_solturaRenewals_solturaContractCommerces] FOREIGN KEY([ContractCommercesId])
REFERENCES [dbo].[SocaiContractCommerces] ([ContractCommercesId])
GO
ALTER TABLE [dbo].[SocaiRenewals] CHECK CONSTRAINT [FK_solturaRenewals_solturaContractCommerces]
GO
ALTER TABLE [dbo].[SocaiRolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_solturaRolePermissions_SolturaPermisions] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[SocaiPermisions] ([PermissionID])
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
ALTER TABLE [dbo].[SocaiSubscriptions]  WITH CHECK ADD  CONSTRAINT [CurrencyTypeId] FOREIGN KEY([CurrencyTypeId])
REFERENCES [dbo].[SocaiCurrencyTypes] ([CurrencyTypeId])
GO
ALTER TABLE [dbo].[SocaiSubscriptions] CHECK CONSTRAINT [CurrencyTypeId]
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
ALTER TABLE [dbo].[SocaiSuscriptionSchedules]  WITH CHECK ADD  CONSTRAINT [ScheduleIdFK1] FOREIGN KEY([ScheduleId])
REFERENCES [dbo].[SocaiSchedules] ([ScheduleId])
GO
ALTER TABLE [dbo].[SocaiSuscriptionSchedules] CHECK CONSTRAINT [ScheduleIdFK1]
GO
ALTER TABLE [dbo].[SocaiSuscriptionSchedules]  WITH CHECK ADD  CONSTRAINT [SubscriptionUserFK] FOREIGN KEY([SubscriptionUserId])
REFERENCES [dbo].[SocaiSubscriptionUser] ([SubscriptionUserId])
GO
ALTER TABLE [dbo].[SocaiSuscriptionSchedules] CHECK CONSTRAINT [SubscriptionUserFK]
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
ALTER TABLE [dbo].[SocaiUsers]  WITH CHECK ADD  CONSTRAINT [FK_solturaUsers_solturaAdresses] FOREIGN KEY([AdressId])
REFERENCES [dbo].[SocaiAdresses] ([AddressId])
GO
ALTER TABLE [dbo].[SocaiUsers] CHECK CONSTRAINT [FK_solturaUsers_solturaAdresses]
GO
ALTER TABLE [dbo].[SocaiValidationQR]  WITH CHECK ADD  CONSTRAINT [SubscriptionUserIdFK3] FOREIGN KEY([SubscriptionUserId])
REFERENCES [dbo].[SocaiSubscriptionUser] ([SubscriptionUserId])
GO
ALTER TABLE [dbo].[SocaiValidationQR] CHECK CONSTRAINT [SubscriptionUserIdFK3]
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
USE [master]
GO
ALTER DATABASE [Caso2] SET  READ_WRITE 
GO
