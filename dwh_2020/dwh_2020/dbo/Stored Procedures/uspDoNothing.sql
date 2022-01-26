CREATE PROCEDURE [dbo].[uspDoNothing]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Does nothing : used to map non updatable views in EF (to prevent updates)
END