CREATE TABLE [FF].[PartijFaunaFlora] (
    [IndieningPartijID] INT            NOT NULL,
    [Commentaar]        NVARCHAR (800) NULL,
    [AangeslotenBijHvv] BIT            DEFAULT ((0)) NOT NULL,
    [Vervaldatum]       DATETIME       NULL,
    [ErkenningsDatum]   DATETIME       NULL,
    [SoftDeleted]       BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]        ROWVERSION     NOT NULL,
    CONSTRAINT [PK_Partij] PRIMARY KEY CLUSTERED ([IndieningPartijID] ASC),
    CONSTRAINT [FK_PartijFaunaFlora_IndieningPartij] FOREIGN KEY ([IndieningPartijID]) REFERENCES [IR].[IndieningPartij] ([IndieningPartijID])
);

