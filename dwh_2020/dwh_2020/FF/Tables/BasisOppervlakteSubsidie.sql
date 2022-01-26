CREATE TABLE [FF].[BasisOppervlakteSubsidie] (
    [IndieningID] INT            NOT NULL,
    [Jaartal]     INT            NOT NULL,
    [NaamWBE]     NVARCHAR (200) NOT NULL,
    [IBAN]        NVARCHAR (34)  NULL,
    [SoftDeleted] BIT            CONSTRAINT [DF_BasisOppervlakteSubsidie_SoftDeleted] DEFAULT ((0)) NOT NULL,
    [RowVersion]  ROWVERSION     NOT NULL,
    CONSTRAINT [PK_BasisOppervlakteSubsidie] PRIMARY KEY CLUSTERED ([IndieningID] ASC),
    CONSTRAINT [FK_BasisOppervlakteSubsidie_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

