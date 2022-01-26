CREATE TABLE [GIS].[IndieningLocatie] (
    [IndieningLocatieID]     INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]            INT              NOT NULL,
    [LocatieTypeID]          NVARCHAR (15)    NOT NULL,
    [IndieningLocatieTypeID] NVARCHAR (15)    NOT NULL,
    [IndieningPartijID]      INT              NULL,
    [Beschrijving]           NVARCHAR (255)   NOT NULL,
    [DynamicInfoSetID]       INT              NULL,
    [LocatieGeometrieID]     UNIQUEIDENTIFIER NULL,
    [SoftDeleted]            BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION       NOT NULL,
    [IndieningLocatieGUID]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_IndieningLocatie] PRIMARY KEY CLUSTERED ([IndieningLocatieID] ASC),
    CONSTRAINT [FK_IndieningLocatie_DynamicInfoSet] FOREIGN KEY ([DynamicInfoSetID]) REFERENCES [IR].[DynamicInfoSet] ([DynamicInfoSetID]),
    CONSTRAINT [FK_IndieningLocatie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_IndieningLocatie_IndieningLocatieType] FOREIGN KEY ([IndieningLocatieTypeID]) REFERENCES [GIS].[IndieningLocatieType] ([IndieningLocatieTypeID]),
    CONSTRAINT [FK_IndieningLocatie_IndieningPartij] FOREIGN KEY ([IndieningPartijID]) REFERENCES [IR].[IndieningPartij] ([IndieningPartijID]),
    CONSTRAINT [FK_IndieningLocatie_LocatieType] FOREIGN KEY ([LocatieTypeID]) REFERENCES [GIS].[LocatieType] ([LocatieTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_IndieningLocatie_IndieningID]
    ON [GIS].[IndieningLocatie]([IndieningID] ASC)
    ON [Indexes];

