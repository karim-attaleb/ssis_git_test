CREATE TABLE [FF].[MeldingBijzondereJacht] (
    [IndieningID]                INT            NOT NULL,
    [SchadeTeVoorkomen]          NVARCHAR (MAX) NULL,
    [VerwachteSchadeID]          NVARCHAR (15)  NULL,
    [VerwachteSchadeToelichting] NVARCHAR (MAX) NULL,
    [BestrijdingsActieID]        NVARCHAR (MAX) NULL,
    [SoftDeleted]                BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                 ROWVERSION     NOT NULL,
    CONSTRAINT [PK_MeldingBijzondereJacht] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_MeldingBijzondereJacht_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

