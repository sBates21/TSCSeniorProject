-- Create script for The Seed Company Senior Project database (TSCSeniorProject) tables.
-- Authors: Sean Bates, Jordan Brown
-- Refer to database schema and other documentation for more detailed database information. 

USE [TSCSeniorProject]
GO

-- Organizations table stores translation consulting companies under which consultants and field coordinators work.
CREATE TABLE [dbo].[Organizations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- UserRoles table stores various types of users for permission purposes.
CREATE TABLE [dbo].[UserRoles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- Users table will include all users of the system regardless of organization or role. 
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserRoleID] [int] NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[EmailAddress] [nvarchar](100) NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- OrganizationID in users table is foreign key referencing ID field of Organizations table.
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Organizations] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organizations] ([ID])
GO

-- UserRoleID in users table is foreign key referencing ID field of UserRoles table.
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([UserRoleID])
REFERENCES [dbo].[UserRoles] ([ID])
GO

-- Addresses table stores mailing addresses for users, allowing each user to store multiple addresses.
CREATE TABLE [dbo].[Addresses](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](100) NULL,
	[Zip] [int] NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- UserID in adresses table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO

-- Roles table stores the role(s) a consultant can fill on a translation project. 
CREATE TABLE [dbo].[Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NULL,
	[Description] [nvarchar](1000) NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- Consultant_Roles table stores associations between consultants and the role(s) they have served on projects. 
CREATE TABLE [dbo].[Consultant_Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- UserID in Consultant_Roles table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Consultant_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Consultant_Roles_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO

-- RoleID in Consultant_Roles table is foreign key referencing ID field of Roles table.
ALTER TABLE [dbo].[Consultant_Roles]  WITH CHECK ADD  CONSTRAINT [FK_Consultant_Roles_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
GO

-- Testaments table stores the testament(s) a consultant has worked with on translation projects. 
CREATE TABLE [dbo].[Testaments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- Consultant_Testaments table stores associations between consultants and the testament(s) they've worked with on projects. 
CREATE TABLE [dbo].[Consultant_Testaments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[TestamentID] [int] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- UserID in Consultant_Testaments table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Consultant_Testaments]  WITH CHECK ADD  CONSTRAINT [FK_Consultant_Testaments_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO

-- TestamentID in Consultant_Testaments table is foreign key referencing ID field of Testaments table.
ALTER TABLE [dbo].[Consultant_Testaments]  WITH CHECK ADD  CONSTRAINT [FK_Consultant_Testaments_Testaments] FOREIGN KEY([TestamentID])
REFERENCES [dbo].[Testaments] ([ID])
GO

-- Sample stored procedure in SQL Server. May or may not decide to use stored procedures for database functions in final application.
CREATE PROCEDURE [dbo].[InsertUser]
(
	@UserRoleID int = 1,
	@OrganizationID int = 1, 
    @Email nvarchar(100) = 'none',
    @FirstName nvarchar(100) = NULL,
	@LastName nvarchar(100) = NULL,
	@IsActive bit = 1
)
AS
BEGIN
    SET NOCOUNT ON

	INSERT INTO [dbo].[Users] ([UserRoleID], [OrganizationID], [EmailAddress], [FirstName], [LastName], [IsActive])
		VALUES (@UserRoleID, @OrganizationID, @Email, @FirstName, @LastName, @IsActive);
END
GO
