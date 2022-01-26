--USE IndieningRegister

CREATE FUNCTION [dbo].[CleanString](@inputString NVARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS

BEGIN
	DECLARE @badStrings VARCHAR(256);
	DECLARE @increment INT= 1;
	WHILE @increment <= DATALENGTH(@inputString)
	BEGIN

		-- Vervang CR en LF door ', '
		SET @inputString = replace(@inputString, CHAR(13)+CHAR(10), ', ')

		-- Delete alle speciale characters zoals CR, LF, TAB, DEL, Backspace, ESC, ...
		IF (ASCII(SUBSTRING(@inputString, @increment, 1)) between 0 and 31
			OR ASCII(SUBSTRING(@inputString, @increment, 1)) = 127
		   )
		BEGIN
			SET @badStrings = CHAR(ASCII(SUBSTRING(@inputString, @increment, 1)));
			SET @inputString = REPLACE(@inputString, @badStrings, '');
			SET @increment=@increment-1; 
		END;
		SET @increment = @increment + 1;
	END;

	-- ";" is list separator in BE in CSV files, dus vervang ";" door "-"
	SET @inputString = REPLACE(@inputString, ';', '-')

	RETURN @inputString;

END;