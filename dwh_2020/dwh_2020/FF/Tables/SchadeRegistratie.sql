CREATE TABLE [FF].[SchadeRegistratie] (
    [IndieningID]        INT            NOT NULL,
    [PlantsoortID]       NVARCHAR (15)  NULL,
    [SchadebedragID]     NVARCHAR (15)  NULL,
    [DatumVeroorzaakt]   DATETIME       NULL,
    [DatumVaststelling]  DATETIME       NULL,
    [SchadeBeschrijving] NVARCHAR (MAX) NULL,
    [Commentaar]         NVARCHAR (MAX) NULL,
    [SoftDeleted]        BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]         ROWVERSION     NOT NULL,
    PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_SchadeRegistratie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

