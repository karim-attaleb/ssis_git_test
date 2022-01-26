CREATE TABLE [FF].[IndieningLocatieFaunaFlora] (
    [IndieningLocatieID] INT            NOT NULL,
    [PlantsoortID]       NVARCHAR (15)  NULL,
    [DiersoortTypeID]    NVARCHAR (15)  NULL,
    [Ras]                NVARCHAR (255) NULL,
    [Leeftijd]           NVARCHAR (50)  NULL,
    [Geslacht]           NVARCHAR (15)  NULL,
    [Comment]            NVARCHAR (800) NULL,
    [SoftDeleted]        BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]         ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningLocatieFaunaFlora] PRIMARY KEY CLUSTERED ([IndieningLocatieID] ASC),
    CONSTRAINT [FK_LocatieLocatieFaunaFlora_IndieningLocatie] FOREIGN KEY ([IndieningLocatieID]) REFERENCES [GIS].[IndieningLocatie] ([IndieningLocatieID]),
    CONSTRAINT [FK_LocatieLocatieFaunaFlora_Plantsoort] FOREIGN KEY ([PlantsoortID]) REFERENCES [FF].[Plantsoort] ([PlantsoortID])
);


GO
CREATE NONCLUSTERED INDEX [IX_IndieningLocatie_IndieningLocatieID]
    ON [FF].[IndieningLocatieFaunaFlora]([IndieningLocatieID] ASC)
    ON [Indexes];

