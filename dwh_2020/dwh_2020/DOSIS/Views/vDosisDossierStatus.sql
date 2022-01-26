CREATE VIEW [DOSIS].vDosisDossierStatus
AS
SELECT [DosisDossierStatusID]
      ,[DossierStatusID]
      ,[VlaamsCode]
      ,[VlaamsFase]
  FROM [DOSIS].[DosisDossierStatus]
 WHERE [TotDatum] is null and [SoftDeleted] = 0;