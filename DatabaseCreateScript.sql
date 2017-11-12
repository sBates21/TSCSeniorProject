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

-- Media table stores the media(ums) a consultant has worked with on translation projects.
CREATE TABLE [dbo].[Media](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NULL,
	[Description] [nvarchar](100) NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- Consultant_Media table stores associations between consultants and the media(ums) they've worked with on projects.
CREATE TABLE [dbo].[Consultant_Media](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[MediaID] [int] NOT NULL,
	PRIMARY KEY(ID)
	)
GO

-- UserID in Consultant_Media table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Consultant_Media]  WITH CHECK ADD  CONSTRAINT [FK_Consultant_Media_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO

-- TestamentID in Consultant_Media table is foreign key referencing ID field of Media table.
ALTER TABLE [dbo].[Consultant_Media]  WITH CHECK ADD  CONSTRAINT [FK_Consultant_Media_Media] FOREIGN KEY([MediaID])
REFERENCES [dbo].[Media] ([ID])
GO

-- Regions table stores the region(s) a consultant is available to work in for future projects.
CREATE TABLE [dbo].[Regions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO
-- Consultant_Regions table stores associations between consultants and the region(s) a consultant is available to work in for future projects.
CREATE TABLE [dbo].[Consultant_Regions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RegionID] [int] NOT NULL,
	PRIMARY KEY(ID)
  )
GO

-- UserID in Consultant_Regions is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Consultant_Regions] WITH CHECK ADD CONSTRAINT [FK_Consultant_Regions_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO

-- RegionID in Consultant_Regions is foreign key referncing ID field of Regions table.
ALTER TABLE [dbo].[Consultant_Regions] WITH CHECK ADD CONSTRAINT [FK_Consultant_Regions_Regions] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Regions] ([ID])
GO

-- Languages Wider Communication table stores the region(s) a consultant is available to work in for future projects.
CREATE TABLE [dbo].[Languages_Wider_Communication](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
	)
GO
-- Consultant_Languages_Wider_Communication table stores associations between consultants and the region(s) a consultant is available to work in for future projects.
CREATE TABLE [dbo].[Consultant_Languages_Wider_Communication](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[LanguageID] [int] NOT NULL,
	[Speaks] [int] NOT NULL,
	[Listens] [int] NOT NULL,
	[Writes] [int] NOT NULL,
	[Reads] [int] NOT NULL,
	PRIMARY KEY(ID)
  )
GO

-- UserID in Consultant_Languages_Wider_Communication is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Consultant_Languages_Wider_Communication] WITH CHECK ADD CONSTRAINT [FK_Consultant_Languages_Wider_Communication_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO

-- RegionID in Consultant_Languages_Wider_Communication is foreign key referncing ID field of Languages_Wider_Communication table.
ALTER TABLE [dbo].[Consultant_Languages_Wider_Communication] WITH CHECK ADD CONSTRAINT [FK_Consultant_Languages_Wider_Communication_Languages_Wider_Communication] FOREIGN KEY([RegionID])
REFERENCES [dbo].[Languages_Wider_Communication] ([ID])
GO

-- Assignments stores the assignment load for a user
CREATE TABLE [dbo].[Assignments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[StageID] [int] NOT NULL,
	[LanguageWiderCommunication] [int] NOT NULL,
  --Can't remember what this is. Don't know how to capture.
	--[LanguageFamily] [] NOT NULL,
	[CheckLocation] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Notes] [nvarchar] (250),
	[IsActive] [bit] NOT NULL,
	PRIMARY KEY(ID)
)
GO

-- UserID in Assignments table is foregin key referencing ID field in the User table.
ALTER TABLE [dbo].[Assignments] WITH CHECK ADD CONSTRAINT [FK_Assignments_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO

--StageID in Assignments table is foreign key referencing ID from Tbl_Stage Languages
ALTER TABLE [dbo].[Assignments] WITH CHECK ADD CONSTRAINT [FK_Assignments_Tbl_StageLanguages] FOREIGN KEY([StageID])
REFERENCES [dbo].[Tbl_StageLanguages] ([ID])
GO

--Reports table stores the reports that users create for an Assignments
CREATE TABLE [dbo].[Reports](
	[ID] [int] IDENTITY(1,1) NOT NULL,
  [UserID] [int] NOT NULL,
	[AssignmentID] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[Notes] [nvarchar](250),
	PRIMARY KEY(ID)
)
GO

-- UserID in Reports table is foreign key referencing ID field in the User TABLE
ALTER TABLE [dbo].[Reports] WITH CHECK ADD CONSTRAINT [FK_Reports_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO

-- AssignmentID in Reports table is foreign key referencing ID field in the Assignments table.
ALTER TABLE [dbo].[Reports] WITH CHECK ADD CONSTRAINT [FK_Reports_Assignments] FOREIGN KEY([AssignmentID])
REFERENCES [dbo].[Assignments([ID])
GO

--Books table stores the information of the books of the Bible
CREATE TABLE [dbo].[Books](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DisplayName] [nvarchar](100),
	PRIMARY KEY(ID)
)
GO

--Assignments_Books stores the associations that assignments has with books
CREATE TABLE [dbo].[Assignment_Books](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AssignmentID] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[StartChapter] [int] NOT NULL,
	[EndChapter] [int] NOT NULL,
	PRIMARY KEY(ID)
)
GO

--Need foreign Keys for assignment_books relations?
--BookID is a foreign Key referencing the ID field in books Table.
ALTER TABLE [dbo].[Assignment_Books] WITH CHECK ADD CONSTRAINT [FK_Assignment_Books_Books] FOREIGN KEY([BookID])
REFERENCES [dbo].[Books([ID])]
GO

--AssignmentID is a foreign key referncing the ID Field in the Assignments Table.
ALTER TABLE [dbo].[Assignment_Books] WITH CHECK ADD CONSTRAINT [FK_Assignment_Books_Assignments] FOREIGN KEY([AssignmentID])
REFERENCES [dbo].[Assignments([ID])]
GO

--Consultant_info table stores the personal information of consultants
CREATE TABLE [dbo].[Consultant_Info](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Supervisor_FirstName] [nvarchar] NOT NULL,
	[Supervisor_LastName] [nvarchar] NOT NULL,
	[Supervisor_Email] [nvarchar] NOT NULL,
	[AccreditedBy] [nvarchar] NOT NULL,
	[DateOfAccredidation] [date] NOT NULL,
	[LevelOfConsultant] [int] NOT NULL,
	[Biography] [nvarchar](250) NOT NULL,
	PRIMARY KEY(ID)
)
GO

--UserID is a foreign key that references ID field in the Users Table.
ALTER TABLE [dbo].[Consultant_Info] WITH CHECK ADD CONSTRAINT [FK_Consultant_Info_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users([ID])]
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
