CREATE TABLE [IR].[IndieningRelatie] (
    [IndieningRelatieID]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FromIndieningID]        INT           NOT NULL,
    [ToIndieningID]          INT           NOT NULL,
    [IndieningRelatieTypeID] NVARCHAR (15) NOT NULL,
    [SoftDeleted]            BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION    NOT NULL,
    CONSTRAINT [PK_IndieningRelatie] PRIMARY KEY CLUSTERED ([IndieningRelatieID] ASC),
    CONSTRAINT [FK_IndieningRelatie_From] FOREIGN KEY ([FromIndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_IndieningRelatie_IndieningRelatieType] FOREIGN KEY ([IndieningRelatieTypeID]) REFERENCES [IR].[IndieningRelatieType] ([IndieningRelatieTypeID]),
    CONSTRAINT [FK_IndieningRelatie_To] FOREIGN KEY ([ToIndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [UK_IndieningRelatie] UNIQUE NONCLUSTERED ([FromIndieningID] ASC, [ToIndieningID] ASC, [IndieningRelatieTypeID] ASC)
);

