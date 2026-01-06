
CREATE PROC GetCatalogByDescription
  @NewDesciption nvarchar(100)
AS
BEGIN
  SELECT
    *
  FROM
    [catalog] c
  WHERE
    c.[description] = @NewDesciption;
END

GO

