CREATE   FUNCTION dbo.Temp_ConvertToLocalTime (@input DATETIME)
RETURNS DATETIME
AS BEGIN
	RETURN DATEADD(hh, CAST(SUBSTRING(datename(tzoffset, @input AT TIME ZONE 'Central European Standard Time'), 2, 2) AS INT), @input);
END;