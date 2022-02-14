IF
NOT EXISTS (
    SELECT * FROM Lookup.FeedbackType 
    WHERE Id = 1
)
BEGIN
    INSERT INTO Lookup.FeedbackType
    VALUES (1, 'Bug')
END
IF
NOT EXISTS (
    SELECT * FROM Lookup.FeedbackType 
    WHERE Id = 2
)
BEGIN
    INSERT
    INTO Lookup.FeedbackType
    VALUES (2, 'Suggestion')
END
IF
NOT EXISTS (
    SELECT * FROM Lookup.FeedbackType 
    WHERE Id = 3
)
BEGIN
    INSERT
    INTO Lookup.FeedbackType
    VALUES (3, 'Inquiry')
END