CREATE TABLE [IR].[Kaartlaag] (
    [KaartlaagID]            INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]            INT              NULL,
    [KaartlaagTypeID]        NVARCHAR (15)    NOT NULL,
    [IndieningLocatieID]     INT              NULL,
    [IndieningLocatieTypeID] NVARCHAR (15)    NOT NULL,
    [IndieningPartijID]      INT              NULL,
    [Percentage]             DECIMAL (6, 3)   DEFAULT ((0)) NOT NULL,
    [Oppervlakte_ha]         DECIMAL (18, 6)  NULL,
    [IsOverlap]              BIT              DEFAULT ((0)) NOT NULL,
    [SoftDeleted]            BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION       NOT NULL,
    [KaartlaagGUID]          UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Description]            NVARCHAR (100)   NULL,
    [Ligging]                NVARCHAR (100)   NULL,
    CONSTRAINT [PK_Kaartlaag] PRIMARY KEY CLUSTERED ([KaartlaagID] ASC),
    CONSTRAINT [FK_Kaartlaag_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_Kaartlaag_IndieningLocatie] FOREIGN KEY ([IndieningLocatieID]) REFERENCES [GIS].[IndieningLocatie] ([IndieningLocatieID]),
    CONSTRAINT [FK_Kaartlaag_IndieningLocatieType] FOREIGN KEY ([IndieningLocatieTypeID]) REFERENCES [GIS].[IndieningLocatieType] ([IndieningLocatieTypeID]),
    CONSTRAINT [FK_Kaartlaag_IndieningPartij] FOREIGN KEY ([IndieningPartijID]) REFERENCES [IR].[IndieningPartij] ([IndieningPartijID]),
    CONSTRAINT [FK_Kaartlaag_KaartlaagType] FOREIGN KEY ([KaartlaagTypeID]) REFERENCES [IR].[KaartlaagType] ([KaartlaagTypeID])
);

