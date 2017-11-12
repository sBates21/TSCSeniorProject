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
ALTER TABLE [dbo].[Users] WITH CHECK ADD CONSTRAINT [FK_Users_Organizations] FOREIGN KEY([OrganizationID])
    REFERENCES [dbo].[Organizations] ([ID])
GO

-- UserRoleID in users table is foreign key referencing ID field of UserRoles table.
ALTER TABLE [dbo].[Users] WITH CHECK ADD CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([UserRoleID])
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

-- UserID in addresses table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Addresses] WITH CHECK ADD CONSTRAINT [FK_Addresses_Users] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([ID])
GO

-- Consultant_Info table stores information specific to consultants that doesn't apply to other users. 
CREATE TABLE [dbo].[Consultant_Info](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
    [Supervisor_FirstName] [nvarchar] (100) NULL,
    [Supervisor_LastName] [nvarchar] (100) NULL,
    [Supervisor_Email] [nvarchar] (100) NULL,
    [AccreditedBy] [nvarchar] (100) NULL,
    [DateOfAccredidation] [date] NULL,
    [LevelOfConsultant] [nvarchar] (100) NULL,
    [Biography] [nvarchar] (1000) NULL
    PRIMARY KEY(ID)
    )
GO

-- UserID in Consultant_Info table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Consultant_Info] WITH CHECK ADD CONSTRAINT [FK_Consultant_Info_Users] FOREIGN KEY([UserID])
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
ALTER TABLE [dbo].[Consultant_Roles] WITH CHECK ADD CONSTRAINT [FK_Consultant_Roles_Users] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([ID])
GO

-- RoleID in Consultant_Roles table is foreign key referencing ID field of Roles table.
ALTER TABLE [dbo].[Consultant_Roles] WITH CHECK ADD CONSTRAINT [FK_Consultant_Roles_Roles] FOREIGN KEY([RoleID])
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
ALTER TABLE [dbo].[Consultant_Testaments] WITH CHECK ADD CONSTRAINT [FK_Consultant_Testaments_Users] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([ID])
GO

-- TestamentID in Consultant_Testaments table is foreign key referencing ID field of Testaments table.
ALTER TABLE [dbo].[Consultant_Testaments] WITH CHECK ADD CONSTRAINT [FK_Consultant_Testaments_Testaments] FOREIGN KEY([TestamentID])
    REFERENCES [dbo].[Testaments] ([ID])
GO

-- Media table stores the various media a consultant has worked with on translation projects. 
CREATE TABLE [dbo].[Media](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [DisplayName] [nvarchar](100) NULL,
    [Description] [nvarchar](100) NULL,
    [IsActive] [bit] NOT NULL,
    PRIMARY KEY(ID)
    )
GO

-- Consultant_Media table stores associations between consultants and the media they've worked with on projects. 
CREATE TABLE [dbo].[Consultant_Media](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
    [MediaID] [int] NOT NULL,
    PRIMARY KEY(ID)
    )
GO

-- UserID in Consultant_Media table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Consultant_Media] WITH CHECK ADD CONSTRAINT [FK_Consultant_Media_Users] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([ID])
GO

-- MediaID in Consultant_Media table is foreign key referencing ID field of Media table.
ALTER TABLE [dbo].[Consultant_Media] WITH CHECK ADD CONSTRAINT [FK_Consultant_Media_Media] FOREIGN KEY([MediaID])
    REFERENCES [dbo].[Media] ([ID])
GO

-- Regions table stores the regions where a consultant has worked on translation projects. 
CREATE TABLE [dbo].[Regions](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [DisplayName] [nvarchar](100) NULL,
    [IsActive] [bit] NOT NULL,
    PRIMARY KEY(ID)
    )
GO

-- Consultant_Regions table stores associations between consultants and the regions where they've worked on projects. 
CREATE TABLE [dbo].[Consultant_Regions](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
    [RegionID] [int] NOT NULL,
    PRIMARY KEY(ID)
    )
GO

-- UserID in Consultant_Regions table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Consultant_Regions] WITH CHECK ADD CONSTRAINT [FK_Consultant_Regions_Users] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([ID])
GO

-- RegionID in Consultant_Regions table is foreign key referencing ID field of Regions table.
ALTER TABLE [dbo].[Consultant_Regions] WITH CHECK ADD CONSTRAINT [FK_Consultant_Regions_Regions] FOREIGN KEY([RegionID])
    REFERENCES [dbo].[Regions] ([ID])
GO

-- Languages_Wider_Communication table stores the common languages between consultants and local peoples on projects. 
CREATE TABLE [dbo].[Languages_Wider_Communication](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [DisplayName] [nvarchar](100) NULL,
    [IsActive] [bit] NOT NULL,
    PRIMARY KEY(ID)
    )
GO

-- Consultant_Languages_Wider_Communication table stores associations between consultants and the languages of wider communication in which they're proficient. 
CREATE TABLE [dbo].[Consultant_Languages_Wider_Communication](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
    [Language_Wider_CommunicationID] [int] NOT NULL,
    [Speaks] [int] NULL,
    [Listens] [int] NULL,
    [Writes] [int] NULL,
    [Reads] [int] NULL,
    PRIMARY KEY(ID)
    )
GO

-- UserID in Consultant_Languages_Wider_Communication table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Consultant_Languages_Wider_Communication] WITH CHECK ADD CONSTRAINT [FK_Consultant_Languages_Wider_Communication_Users] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([ID])
GO

-- Language_Wider_CommunicationID in Consultant_Languages_Wider_Communication table is foreign key referencing ID field of Languages_Wider_Communication table.
ALTER TABLE [dbo].[Consultant_Languages_Wider_Communication] WITH CHECK ADD CONSTRAINT [FK_Consultant_Languages_Wider_Communication_Languages_Wider_Communication] FOREIGN KEY([Language_Wider_CommunicationID])
    REFERENCES [dbo].[Languages_Wider_Communication] ([ID])
GO

-- Assignments table stores information about an assignment of a consultant to a project
CREATE TABLE [dbo].[Assignments](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
    [StageID] [int] NOT NULL,
    [LanguageWiderCommunication] [nvarchar](100) NULL,
    [LanguageFamily] [nvarchar](100) NULL,
    [CheckLocation] [nvarchar](100) NULL,
    [StartDate] [date] NULL,
    [EndDate] [date] NULL,
    [Notes] [nvarchar] (1000) NULL,
    PRIMARY KEY(ID)
    )
GO

-- UserID in assignments table is foreign key referencing ID field of Users table.
ALTER TABLE [dbo].[Assignments] WITH CHECK ADD CONSTRAINT [FK_Assignments_Users] FOREIGN KEY([UserID])
    REFERENCES [dbo].[Users] ([ID])
GO

-- Books table stores the books of the Bible worked on during translation projects. 
CREATE TABLE [dbo].[Books](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [DisplayName] [nvarchar](100) NULL,
    PRIMARY KEY(ID)
	)
GO

-- Assignment_Books table stores associations between assignments and books of the Bible being worked on.
CREATE TABLE [dbo].[Assignment_Books](
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [AssignmentID] [int] NOT NULL,
    [BookID] [int] NOT NULL,
    [StartChapter] [int] NOT NULL,
    [EndChapter] [int] NOT NULL,
    PRIMARY KEY(ID)
    )
GO

-- AssignmentID in Assignment_Books table is foreign key referencing ID field of Assignments table.
ALTER TABLE [dbo].[Assignment_Books] WITH CHECK ADD CONSTRAINT [FK_Assignment_Books_Assignments] FOREIGN KEY([AssignmentID])
    REFERENCES [dbo].[Assignments] ([ID])
GO

-- BookID in Assignment_Books table is foreign key referencing ID field of Books table.
ALTER TABLE [dbo].[Assignment_Books] WITH CHECK ADD CONSTRAINT [FK_Assignment_Books_Books] FOREIGN KEY([BookID])
    REFERENCES [dbo].[Books] ([ID])
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
