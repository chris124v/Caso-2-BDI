USE [caso2]
GO
/****** Object:  Table [dbo].[CommercesFeatures]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommercesFeatures](
	[CommercesFeaturesId] [int] NOT NULL,
	[CommercesId] [int] NOT NULL,
	[FeaturesId] [int] NOT NULL,
	[mediaId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_CommercesFeatures] PRIMARY KEY CLUSTERED 
(
	[CommercesFeaturesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[featuresSubscriptions]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[featuresSubscriptions](
	[featuresSubscriptionsID] [int] NOT NULL,
	[FeatureId] [int] NOT NULL,
	[SubscriptionId] [int] NOT NULL,
	[Quantity] [float] NOT NULL,
	[Unit] [varchar](100) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_featuresSubscriptions] PRIMARY KEY CLUSTERED 
(
	[featuresSubscriptionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaAdresses]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaAdresses](
	[AddressId] [int] NOT NULL,
	[PostalCode] [varchar](20) NOT NULL,
	[CityId] [int] NOT NULL,
	[direccion] [varchar](250) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaAdresses] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaCities]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaCities](
	[CityID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[solturaCommerces]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaCommerces](
	[CommerceId] [int] NOT NULL,
	[Name] [varchar](225) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[AdressId] [int] NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Email] [varchar](200) NOT NULL,
	[MediaID] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaCommerces] PRIMARY KEY CLUSTERED 
(
	[CommerceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaContractCommerces]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaContractCommerces](
	[ContractCommercesId] [int] NOT NULL,
	[ValidFrom] [datetime] NOT NULL,
	[ValidTo] [datetime] NOT NULL,
	[ContractType] [varchar](50) NOT NULL,
	[ContractDescription] [varchar](150) NOT NULL,
	[isActive] [bit] NOT NULL,
	[disscountPercentage] [float] NOT NULL,
	[CommerceId] [int] NOT NULL,
	[inChargeSignature] [varchar](100) NOT NULL,
	[mediaId] [int] NOT NULL,
 CONSTRAINT [PK_solturaContractCommerces] PRIMARY KEY CLUSTERED 
(
	[ContractCommercesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaContractObligations]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaContractObligations](
	[obligationsId] [int] NOT NULL,
	[AmountToPay] [float] NOT NULL,
	[currencyId] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[startdate] [datetime] NOT NULL,
	[limitdate] [datetime] NOT NULL,
	[contractCommercesID] [int] NOT NULL,
 CONSTRAINT [PK_solturaContractObligations] PRIMARY KEY CLUSTERED 
(
	[obligationsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SolturaPermisions]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SolturaPermisions](
	[PermissionID] [int] NOT NULL,
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
/****** Object:  Table [dbo].[solturaPlanFeatures]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaPlanFeatures](
	[FeatureId] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[Category] [varchar](50) NOT NULL,
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
/****** Object:  Table [dbo].[solturaProvinces]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaProvinces](
	[ProvinciasId] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Createdate] [datetime] NOT NULL,
	[Updatedate] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaProvinces] PRIMARY KEY CLUSTERED 
(
	[ProvinciasId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaRenewals]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaRenewals](
	[renewalId] [int] NOT NULL,
	[renewalDate] [datetime] NOT NULL,
	[renewalMotive] [varchar](250) NOT NULL,
	[ContractCommercesId] [int] NOT NULL,
	[mediaId] [int] NOT NULL,
 CONSTRAINT [PK_solturaRenewals] PRIMARY KEY CLUSTERED 
(
	[renewalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaRolePermissions]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaRolePermissions](
	[RolePermissionId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[PermissionID] [int] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaRolePermissions] PRIMARY KEY CLUSTERED 
(
	[RolePermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaRoles]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaRoles](
	[RoleId] [int] NOT NULL,
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
/****** Object:  Table [dbo].[solturaSubscriptions]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaSubscriptions](
	[SubscriptionId] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](250) NOT NULL,
	[isCustomizable] [bit] NOT NULL,
	[isActive] [bit] NOT NULL,
	[createdAt] [datetime] NOT NULL,
	[updatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaSubscriptions] PRIMARY KEY CLUSTERED 
(
	[SubscriptionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[solturaUsers]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[solturaUsers](
	[UserId] [int] NOT NULL,
	[Name] [varchar](250) NOT NULL,
	[Email] [varchar](220) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Password] [varbinary](100) NOT NULL,
	[AdressId] [int] NOT NULL,
	[mediaID] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
	[LastLogin] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_solturaUsers] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userRoles]    Script Date: 31/3/2025 15:58:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userRoles](
	[UserRoleId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_userRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CommercesFeatures]  WITH CHECK ADD  CONSTRAINT [FK_CommercesFeatures_solturaCommerces] FOREIGN KEY([CommercesId])
REFERENCES [dbo].[solturaCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[CommercesFeatures] CHECK CONSTRAINT [FK_CommercesFeatures_solturaCommerces]
GO
ALTER TABLE [dbo].[CommercesFeatures]  WITH CHECK ADD  CONSTRAINT [FK_CommercesFeatures_solturaPlanFeatures] FOREIGN KEY([FeaturesId])
REFERENCES [dbo].[solturaPlanFeatures] ([FeatureId])
GO
ALTER TABLE [dbo].[CommercesFeatures] CHECK CONSTRAINT [FK_CommercesFeatures_solturaPlanFeatures]
GO
ALTER TABLE [dbo].[featuresSubscriptions]  WITH CHECK ADD  CONSTRAINT [FK_featuresSubscriptions_solturaPlanFeatures] FOREIGN KEY([FeatureId])
REFERENCES [dbo].[solturaPlanFeatures] ([FeatureId])
GO
ALTER TABLE [dbo].[featuresSubscriptions] CHECK CONSTRAINT [FK_featuresSubscriptions_solturaPlanFeatures]
GO
ALTER TABLE [dbo].[featuresSubscriptions]  WITH CHECK ADD  CONSTRAINT [FK_featuresSubscriptions_solturaSubscriptions] FOREIGN KEY([SubscriptionId])
REFERENCES [dbo].[solturaSubscriptions] ([SubscriptionId])
GO
ALTER TABLE [dbo].[featuresSubscriptions] CHECK CONSTRAINT [FK_featuresSubscriptions_solturaSubscriptions]
GO
ALTER TABLE [dbo].[solturaAdresses]  WITH CHECK ADD  CONSTRAINT [FK_solturaAdresses_solturaCities] FOREIGN KEY([CityId])
REFERENCES [dbo].[solturaCities] ([CityID])
GO
ALTER TABLE [dbo].[solturaAdresses] CHECK CONSTRAINT [FK_solturaAdresses_solturaCities]
GO
ALTER TABLE [dbo].[solturaCities]  WITH CHECK ADD  CONSTRAINT [FK_solturaCities_solturaProvinces] FOREIGN KEY([ProvinciasId])
REFERENCES [dbo].[solturaProvinces] ([ProvinciasId])
GO
ALTER TABLE [dbo].[solturaCities] CHECK CONSTRAINT [FK_solturaCities_solturaProvinces]
GO
ALTER TABLE [dbo].[solturaCommerces]  WITH CHECK ADD  CONSTRAINT [FK_solturaCommerces_solturaAdresses] FOREIGN KEY([AdressId])
REFERENCES [dbo].[solturaAdresses] ([AddressId])
GO
ALTER TABLE [dbo].[solturaCommerces] CHECK CONSTRAINT [FK_solturaCommerces_solturaAdresses]
GO
ALTER TABLE [dbo].[solturaContractCommerces]  WITH CHECK ADD  CONSTRAINT [FK_solturaContractCommerces_solturaCommerces] FOREIGN KEY([CommerceId])
REFERENCES [dbo].[solturaCommerces] ([CommerceId])
GO
ALTER TABLE [dbo].[solturaContractCommerces] CHECK CONSTRAINT [FK_solturaContractCommerces_solturaCommerces]
GO
ALTER TABLE [dbo].[solturaContractObligations]  WITH CHECK ADD  CONSTRAINT [FK_solturaContractObligations_solturaContractCommerces] FOREIGN KEY([contractCommercesID])
REFERENCES [dbo].[solturaContractCommerces] ([ContractCommercesId])
GO
ALTER TABLE [dbo].[solturaContractObligations] CHECK CONSTRAINT [FK_solturaContractObligations_solturaContractCommerces]
GO
ALTER TABLE [dbo].[solturaRenewals]  WITH CHECK ADD  CONSTRAINT [FK_solturaRenewals_solturaContractCommerces] FOREIGN KEY([ContractCommercesId])
REFERENCES [dbo].[solturaContractCommerces] ([ContractCommercesId])
GO
ALTER TABLE [dbo].[solturaRenewals] CHECK CONSTRAINT [FK_solturaRenewals_solturaContractCommerces]
GO
ALTER TABLE [dbo].[solturaRolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_solturaRolePermissions_SolturaPermisions] FOREIGN KEY([PermissionID])
REFERENCES [dbo].[SolturaPermisions] ([PermissionID])
GO
ALTER TABLE [dbo].[solturaRolePermissions] CHECK CONSTRAINT [FK_solturaRolePermissions_SolturaPermisions]
GO
ALTER TABLE [dbo].[solturaRolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_solturaRolePermissions_solturaRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[solturaRoles] ([RoleId])
GO
ALTER TABLE [dbo].[solturaRolePermissions] CHECK CONSTRAINT [FK_solturaRolePermissions_solturaRoles]
GO
ALTER TABLE [dbo].[solturaUsers]  WITH CHECK ADD  CONSTRAINT [FK_solturaUsers_solturaAdresses] FOREIGN KEY([AdressId])
REFERENCES [dbo].[solturaAdresses] ([AddressId])
GO
ALTER TABLE [dbo].[solturaUsers] CHECK CONSTRAINT [FK_solturaUsers_solturaAdresses]
GO
ALTER TABLE [dbo].[userRoles]  WITH CHECK ADD  CONSTRAINT [FK_userRoles_solturaRoles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[solturaRoles] ([RoleId])
GO
ALTER TABLE [dbo].[userRoles] CHECK CONSTRAINT [FK_userRoles_solturaRoles]
GO
ALTER TABLE [dbo].[userRoles]  WITH CHECK ADD  CONSTRAINT [FK_userRoles_solturaUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[solturaUsers] ([UserId])
GO
ALTER TABLE [dbo].[userRoles] CHECK CONSTRAINT [FK_userRoles_solturaUsers]
GO
