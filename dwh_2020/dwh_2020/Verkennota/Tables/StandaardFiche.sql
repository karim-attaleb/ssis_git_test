CREATE TABLE [Verkennota].[StandaardFiche] (
    [StandaardFicheID]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]          INT           NOT NULL,
    [StandaardFicheTypeID] NVARCHAR (15) NOT NULL,
    [Aantal]               INT           NOT NULL,
    [SoftDeleted]          BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION    NOT NULL,
    CONSTRAINT [PK_StandaardFiche] PRIMARY KEY CLUSTERED ([StandaardFicheID] ASC),
    CONSTRAINT [FK_StandaardFiche_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [Verkennota].[IndieningVerkenningsnota] ([IndieningID]),
    CONSTRAINT [FK_StandaardFiche_StandaardFicheType] FOREIGN KEY ([StandaardFicheTypeID]) REFERENCES [Verkennota].[StandaardFicheType] ([StandaardFicheTypeID])
);

