CREATE TABLE [FF].[IndieningFaunaFlora] (
    [IndieningID]        INT            NOT NULL,
    [DiersoortID]        NVARCHAR (15)  NULL,
    [OntvangstDatum]     DATETIME       NULL,
    [OntvangstCorrect]   BIT            DEFAULT ((0)) NOT NULL,
    [OndertekeningDatum] DATETIME       NULL,
    [Ondertekend]        BIT            DEFAULT ((0)) NOT NULL,
    [Commentaar]         NVARCHAR (800) NULL,
    [IngediendDoorANB]   BIT            DEFAULT ((0)) NOT NULL,
    [NagekekenAnb]       BIT            DEFAULT ((0)) NOT NULL,
    [NagekekenInbo]      BIT            DEFAULT ((0)) NOT NULL,
    [SoftDeleted]        BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]         ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningFaunaFlora] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_Indiening_Diersoort] FOREIGN KEY ([DiersoortID]) REFERENCES [FF].[Diersoort] ([DiersoortID]),
    CONSTRAINT [FK_IndieningFaunaFlora_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);


GO
CREATE NONCLUSTERED INDEX [IX_Indiening_IndieningID]
    ON [FF].[IndieningFaunaFlora]([IndieningID] ASC)
    ON [Indexes];

