CREATE TABLE [FF].[JachtVergunning] (
    [IndieningID]                     INT           NOT NULL,
    [JachtVergunningNummer]           NVARCHAR (15) NULL,
    [VolgNummerGenodigde]             INT           NULL,
    [JachtVerlofNummerAanvrager]      NVARCHAR (15) NULL,
    [GeldigheidDatum1]                DATETIME      NULL,
    [GeldigheidDatum2]                DATETIME      NULL,
    [GeldigheidDatum3]                DATETIME      NULL,
    [GeldigheidDatum4]                DATETIME      NULL,
    [GeldigheidDatum5]                DATETIME      NULL,
    [BijlageJachtVerlofGenodigdeFlag] BIT           DEFAULT ((0)) NOT NULL,
    [BijlageIdentiteitGenodigdeFlag]  BIT           DEFAULT ((0)) NOT NULL,
    [BijlageVerzekeringFlag]          BIT           DEFAULT ((0)) NOT NULL,
    [BijlagePasfotoGenodigdeFlag]     BIT           DEFAULT ((0)) NOT NULL,
    [BijlageBetalingFlag]             BIT           DEFAULT ((0)) NOT NULL,
    [MagdaPasfotoFlag]                BIT           DEFAULT ((0)) NOT NULL,
    [SoftDeleted]                     BIT           DEFAULT ((0)) NOT NULL,
    [RowVersion]                      ROWVERSION    NOT NULL,
    [JachtVergunningTypeID]           NVARCHAR (15) NULL,
    [BetalingTypeID]                  NVARCHAR (15) NULL,
    [Bedrag]                          DECIMAL (10)  NULL,
    CONSTRAINT [PK_JachtVergunning] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_JachtVergunning_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID]),
    CONSTRAINT [FK_JachtVergunning_JachtVergunningType] FOREIGN KEY ([JachtVergunningTypeID]) REFERENCES [FF].[JachtVergunningType] ([JachtVergunningTypeID]),
    CONSTRAINT [FK_JachtVergunning_JachtVerlofVolgNummer] FOREIGN KEY ([VolgNummerGenodigde]) REFERENCES [FF].[JachtVerlofVolgNummer] ([VolgNummer])
);


GO
CREATE NONCLUSTERED INDEX [IX_JachtVergunningNummer]
    ON [FF].[JachtVergunning]([JachtVergunningNummer] ASC);

