-- =============================================
-- Author:		Sam Neefs
-- Create date: 18/12/2017
-- Description:	Returns the envelope(/extents) of the polygons from the given indiening
-- =============================================

CREATE PROCEDURE GIS.GetIndieningLocatieEnvelopePoly
	-- Add the parameters for the stored procedure here
	@IndieningID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  l.IndieningID, GEOMETRY::UnionAggregate(shape.MakeValid()).STEnvelope() as Envelope
	--	  ,case when shape is null then null else shape.MakeValid().STEnvelope() end
	FROM [IndieningRegister].[GIS].[LocatieGeometriePoly] as g
	inner join GIS.IndieningLocatie as l on l.IndieningLocatieID = g.IndieningLocatieID
		and  l.IndieningID = @IndieningID

	group by l.IndieningID

END