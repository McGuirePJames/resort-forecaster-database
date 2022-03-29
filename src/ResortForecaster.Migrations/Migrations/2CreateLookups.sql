IF
NOT EXISTS (SELECT name FROM sys.schemas WHERE name = N'Lookup')
BEGIN
EXEC ('CREATE SCHEMA Lookup;');
END
GO

IF
NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[ResortForecaster].[Lookup].[FeedbackType]') AND type in (N'U'))
BEGIN
CREATE TABLE [ResortForecaster].[Lookup].[FeedbackType]
(
    Id          INT PRIMARY KEY,
    Description nvarchar(100),
)
END

IF
NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[ResortForecaster].[dbo].[Feedback]') AND type in (N'U'))
BEGIN
CREATE TABLE [ResortForecaster].[dbo].[Feedback]
(
    Id             UNIQUEIDENTIFIER PRIMARY KEY,
    Description    nvarchar(2000),
    FeedbackTypeId INT
        CONSTRAINT FK_Feedback_FeedbackTypeId_FeedbackType_Id FOREIGN KEY (FeedbackTypeId)
        REFERENCES Lookup.FeedbackType(Id)
)
END