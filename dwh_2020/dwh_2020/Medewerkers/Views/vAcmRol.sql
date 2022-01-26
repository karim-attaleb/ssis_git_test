


-- =============================================
-- Author:		Luc Schauvaerts
-- Create date: 28/09/2020 - 01/10/2020 - 09/10/2020 - 23/10/2020
-- Description:	Geeft de gebruikersrol aan tussen de medewerker en de IR.ACMRol.
--	view wordt gebruikt in database Medewerkers 
-- =============================================

CREATE VIEW [Medewerkers].[vAcmRol]
AS
SELECT
  [AcmRolID]
, [Description]
, [DependencySet]
, [SortOrder]
, [SoftDeleted]
FROM
  [IR].[AcmRol]
WHERE
  [SoftDeleted] = 0