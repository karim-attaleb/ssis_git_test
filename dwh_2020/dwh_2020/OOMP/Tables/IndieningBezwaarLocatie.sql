CREATE TABLE [OOMP].[IndieningBezwaarLocatie] (
    [IndieningBezwaarLocatieID] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LocatieTypeID]             NVARCHAR (15)    NOT NULL,
    [LocatieGeometrie]          [sys].[geometry] NOT NULL,
    [IndieningBezwaarID]        INT              NOT NULL,
    [LocatieGeometrieType]      NVARCHAR (15)    NOT NULL,
    CONSTRAINT [PK_IndieningBezwaarLocatieID] PRIMARY KEY CLUSTERED ([IndieningBezwaarLocatieID] ASC),
    CONSTRAINT [FK_IndieningLocatie_IndieningBezwaar] FOREIGN KEY ([IndieningBezwaarID]) REFERENCES [OOMP].[IndieningBezwaar] ([IndieningBezwaarID])
);

