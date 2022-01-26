CREATE TABLE [IR].[PartijIdentificatie] (
    [PartijIdentificatieID]     INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningPartijID]         INT              NOT NULL,
    [Waarde]                    VARCHAR (50)     NOT NULL,
    [PartijIdentificatieTypeID] NVARCHAR (15)    NOT NULL,
    [SoftDeleted]               BIT              DEFAULT ((0)) NOT NULL,
    [RowVersion]                ROWVERSION       NOT NULL,
    [PartijIdentificatieGUID]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_PartijIdentificatie] PRIMARY KEY CLUSTERED ([PartijIdentificatieID] ASC),
    CONSTRAINT [FK_PartijIdentificatie_Partij] FOREIGN KEY ([IndieningPartijID]) REFERENCES [IR].[IndieningPartij] ([IndieningPartijID]),
    CONSTRAINT [FK_PartijIdentificatie_PartijIdentificatieType] FOREIGN KEY ([PartijIdentificatieTypeID]) REFERENCES [IR].[PartijIdentificatieType] ([PartijIdentificatieTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PartijIdentificatie_IndieningPartijID]
    ON [IR].[PartijIdentificatie]([IndieningPartijID] ASC, [PartijIdentificatieTypeID] ASC)
    ON [Indexes];

