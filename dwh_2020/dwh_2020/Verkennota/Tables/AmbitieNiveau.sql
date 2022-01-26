CREATE TABLE [Verkennota].[AmbitieNiveau] (
    [AmbitieNiveauID]              INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]                  INT            NOT NULL,
    [AmbitieNiveauTypeID]          NVARCHAR (15)  NOT NULL,
    [AmbitieniveauTypeAfwijkingID] NVARCHAR (15)  NULL,
    [Beschrijving]                 NVARCHAR (MAX) NULL,
    [SoftDeleted]                  BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                   ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([AmbitieNiveauID] ASC),
    CONSTRAINT [FK_AmbitieNiveau_AmbitieNiveauType] FOREIGN KEY ([AmbitieNiveauTypeID]) REFERENCES [Verkennota].[AmbitieNiveauType] ([AmbitieNiveauTypeID]),
    CONSTRAINT [FK_AmbitieNiveau_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID])
);

