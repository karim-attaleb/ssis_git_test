CREATE TABLE [FF].[IndieningTeBeperkenSchade] (
    [IndieningTeBeperkenSchadeID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IndieningID]                 INT            NOT NULL,
    [TeBeperkenSchadeTypeID]      NVARCHAR (15)  NOT NULL,
    [Commentaar]                  NVARCHAR (800) NULL,
    [SoftDeleted]                 BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                  ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningTeBeperkenSchade] PRIMARY KEY CLUSTERED ([IndieningTeBeperkenSchadeID] ASC),
    CONSTRAINT [FK_IndieningTeBeperkenSchade_Indiening] FOREIGN KEY ([IndieningID]) REFERENCES [IR].[Indiening] ([IndieningID])
);

