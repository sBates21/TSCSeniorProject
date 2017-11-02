-- Create script for The Seed Company Senior Project database
-- Refer to database schema and other documentation for more detailed database information. 

USE [TSCSeniorProject]
GO

CREATE TABLE [dbo].[Organizations](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

CREATE TABLE [dbo].[UserRoles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

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

ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Organizations] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organizations] ([ID])
GO

ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([UserRoleID])
REFERENCES [dbo].[UserRoles] ([ID])
GO

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
