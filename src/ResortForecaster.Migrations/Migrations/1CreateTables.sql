IF
NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'ResortForecaster')
BEGIN
    CREATE DATABASE ResortForecaster
END
GO

USE ResortForecaster
IF
NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[SkiResorts]') AND type in (N'U'))
BEGIN
CREATE TABLE SkiResorts
(
    Id          uniqueidentifier PRIMARY KEY,
    Name        nvarchar(100),
    Description nvarchar(500),
    ImageUrl    nvarchar(400),
    Latitude    decimal(8, 6),
    Longitude   decimal(9, 6)
)
END

IF
NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[FavoriteSkiResorts]') AND type in (N'U'))
BEGIN
CREATE TABLE FavoriteSkiResorts
(
    Id          uniqueidentifier PRIMARY KEY,
    SkiResortId uniqueidentifier,
    UserId      uniqueidentifier
        CONSTRAINT FK_FavoriteSkiResorts_Id_SkiResorts_Id FOREIGN KEY (Id)
        REFERENCES SkiResorts(Id)
)
END

IF
NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Avalanches]') AND type in (N'U'))
BEGIN
CREATE TABLE Avalanches
(
    Id         UNIQUEIDENTIFIER,
    ExternalId nvarchar(10),
    Date       DATE,
    Latitude   FLOAT,
    Longitude  FLOAT,
    Elevation  INT,
    Aspect     NVARCHAR(30),
    Type       NVARCHAR(50),
    Cause      NVARCHAR(100),
    Depth      INT,
    Width      INT
)
END

IF
NOT EXISTS (SELECT name FROM sys.schemas WHERE name = N'Lookup')
BEGIN
    EXEC ('CREATE SCHEMA Lookup;');
END
GO

IF
NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[Lookup].[FeedbackType]') AND type in (N'U'))
BEGIN
CREATE TABLE Lookup.FeedbackType
(
    Id          INT PRIMARY KEY,
    Description nvarchar(100),
)
END

IF
NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Feedback]') AND type in (N'U'))
BEGIN
CREATE TABLE dbo.Feedback
(
    Id             UNIQUEIDENTIFIER PRIMARY KEY,
    Description    nvarchar(2000),
    FeedbackTypeId INT
        CONSTRAINT FK_Feedback_FeedbackTypeId_FeedbackType_Id FOREIGN KEY (FeedbackTypeId)
        REFERENCES Lookup.FeedbackType(Id)
)
END