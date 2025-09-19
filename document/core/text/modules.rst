Modules
-------


.. index:: index, type index, tag index, global index, memory index, table index, function index, data index, element index, local index, label index
   pair: text format; type index
   pair: text format; tag index
   pair: text format; global index
   pair: text format; memory index
   pair: text format; table index
   pair: text format; function index
   pair: text format; data index
   pair: text format; element index
   pair: text format; local index
   pair: text format; label index
.. _text-typeidx:
.. _text-tagidx:
.. _text-globalidx:
.. _text-memidx:
.. _text-tableidx:
.. _text-funcidx:
.. _text-dataidx:
.. _text-elemidx:
.. _text-localidx:
.. _text-labelidx:
.. _text-fieldidx:
.. _text-index:

Indices
~~~~~~~

:ref:`Indices <syntax-index>` can be given either in raw numeric form or as symbolic :ref:`identifiers <text-id>` when bound by a respective construct.
Such identifiers are looked up in the suitable space of the :ref:`identifier context <text-context>` :math:`I`.

.. math::
   \begin{array}{llcllllllll}
   \production{type index} & \Ttypeidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\ITYPES[x] = v) \\
   \production{global index} & \Tglobalidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IGLOBALS[x] = v) \\
   \production{tag index} & \Ttagidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\ITAGS[x] = v) \\
   \production{memory index} & \Tmemidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IMEMS[x] = v) \\
   \production{table index} & \Ttableidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\ITABLES[x] = v) \\
   \production{function index} & \Tfuncidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IFUNCS[x] = v) \\
   \production{data index} & \Tdataidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IDATAS[x] = v) \\
   \production{element index} & \Telemidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\IELEMS[x] = v) \\
   \production{local index} & \Tlocalidx_I &::=&
     x{:}\Tu32 &\Rightarrow& x \\&&|&
     v{:}\Tid &\Rightarrow& x & (\iff I.\ILOCALS[x] = v) \\
   \production{label index} & \Tlabelidx_I &::=&
     l{:}\Tu32 &\Rightarrow& l \\&&|&
     v{:}\Tid &\Rightarrow& l & (\iff I.\ILABELS[l] = v) \\
   \production{field index} & \Tfieldidx_{I,x} &::=&
     i{:}\Tu32 &\Rightarrow& i \\&&|&
     v{:}\Tid &\Rightarrow& i & (\iff I.\IFIELDS[x][i] = v) \\
   \end{array}


.. index:: tag, tag type, identifier, function type, exception tag
   pair: text format; tag
.. _text-tag:

Tags
~~~~

An tag definition can bind a symbolic :ref:`tag identifier <text-id>`.

.. math::
   \begin{array}{llcl}
   \production{tag} & \Ttag_I &::=&
     \text{(}~\text{tag}~~\Tid^?~~\X{tt}{:}\Ttagtype_I~\text{)} \\ &&& \qquad
       \Rightarrow\quad \TAG~\X{tt} \\
   \end{array}

.. index:: import, name
   pair: text format; import
.. index:: export, name, index, tag index
   pair: text format; export
.. index:: tag
.. _text-tag-abbrev:

Abbreviations
.............

Tags can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{tag}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Ttagtype~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{tag}~~\Tid^?~~\Ttagtype~\text{)}~\text{)}
       \\[1ex] &
     \text{(}~\text{tag}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{tag}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{tag}~~\Tid'~~\dots~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. note::
   The latter abbreviation can be applied repeatedly, if ":math:`\dots`" contains additional export clauses.
   Consequently, a memory declaration can contain any number of exports, possibly followed by an import.


.. index:: global, global type, identifier, expression
   pair: text format; global
.. _text-global:

Globals
~~~~~~~

Global definitions can bind a symbolic :ref:`global identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{global} & \Tglobal_I &::=&
     \text{(}~\text{global}~~\Tid^?~~\X{gt}{:}\Tglobaltype_I~~e{:}\Texpr_I~\text{)}
       &\Rightarrow& \GLOBAL~\X{gt}~e \\
   \end{array}


.. index:: import, name
   pair: text format; import
.. index:: export, name, index, global index
   pair: text format; export
.. _text-global-abbrev:

Abbreviations
.............

Globals can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{global}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Tglobaltype~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{global}~~\Tid^?~~\Tglobaltype~\text{)}~\text{)}
       \\[1ex] &
     \text{(}~\text{global}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{global}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{global}~~\Tid'~~\dots~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. note::
   The latter abbreviation can be applied repeatedly, if ":math:`\dots`" contains additional export clauses.
   Consequently, a global declaration can contain any number of exports, possibly followed by an import.


.. index:: memory, memory type, identifier
   pair: text format; memory
.. _text-mem:

Memories
~~~~~~~~

Memory definitions can bind a symbolic :ref:`memory identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{memory} & \Tmem_I &::=&
     \text{(}~\text{memory}~~\Tid^?~~\X{mt}{:}\Tmemtype_I~\text{)}
       &\Rightarrow& \MEMORY~\X{mt} \\
   \end{array}


.. index:: import, name
   pair: text format; import
.. index:: export, name, index, memory index
   pair: text format; export
.. index:: data, memory, memory index, expression, byte, page size
   pair: text format; data
   single: memory; data
   single: data; segment
.. _text-mem-abbrev:

Abbreviations
.............

A :ref:`data segment <text-data>` can be given inline with a memory definition, in which case its offset is :math:`0` and the :ref:`limits <text-limits>` of the :ref:`memory type <text-memtype>` are inferred from the length of the data, rounded up to :ref:`page size <page-size>`:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{memory}~~\Tid^?~~\Taddrtype^?~~\text{(}~\text{data}~~b^n{:}\Tdatastring~\text{)}~~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{memory}~~\Tid'~~\Taddrtype^?~~m~~m~\text{)} \\ & \qquad
       \text{(}~\text{data}~~\text{(}~\text{memory}~~\Tid'~\text{)}~~\text{(}~\Taddrtype'\text{.const}~~\text{0}~\text{)}~~\Tdatastring~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh, \\ & \qquad\qquad
        \iff \Taddrtype? \neq \epsilon \wedge \Taddrtype' = \Taddrtype^? \vee \Taddrtype^? = \epsilon \wedge \Taddrtype' = \text{i32}, \\ & \qquad\qquad
        m = \F{ceil}(n / 64\,\F{Ki})) \\
   \end{array}

Memories can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Tmemtype~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{memory}~~\Tid^?~~\Tmemtype~\text{)}~\text{)}
       \\[1ex] &
     \text{(}~\text{memory}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{memory}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{memory}~~\Tid'~~\dots~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. note::
   The latter abbreviation can be applied repeatedly, if ":math:`\dots`" contains additional export clauses.
   Consequently, a memory declaration can contain any number of exports, possibly followed by an import.


.. index:: table, table type, identifier, expression
   pair: text format; table
.. _text-table:

Tables
~~~~~~

Table definitions can bind a symbolic :ref:`table identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{table} & \Ttable_I &::=&
     \text{(}~\text{table}~~\Tid^?~~\X{tt}{:}\Ttabletype_I~~e{:}\Texpr_I~\text{)}
       &\Rightarrow& \TABLE~\X{tt}~e \\
   \end{array}


.. index:: reference type, heap type
.. index:: import, name
   pair: text format; import
.. index:: export, name, index, table index
   pair: text format; export
.. index:: element, table index, function index
   pair: text format; element
   single: table; element
   single: element; segment
.. _text-table-abbrev:

Abbreviations
.............

A table's initialization :ref:`expression <text-expr>` can be omitted, in which case it defaults to :math:`\REFNULL`:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\Ttabletype~\text{)}
       &\equiv&
       \text{(}~\text{table}~~\Tid^?~~\Ttabletype~~\text{(}~\REFNULL~\X{ht}~\text{)}~\text{)}
       \\ &&& \qquad\qquad
       (\iff \Ttabletype = \Taddrtype^?~\Tlimits~\text{(}~\text{ref}~\text{null}^?~\X{ht}~\text{)}) \\
   \end{array}

An :ref:`element segment <text-elem>` can be given inline with a table definition, in which case its offset is :math:`0` and the :ref:`limits <text-limits>` of the :ref:`table type <text-tabletype>` are inferred from the length of the given segment:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\Taddrtype^?~~\Treftype~~\text{(}~\text{elem}~~\expr^n{:}\Tlist(\Telemexpr)~\text{)}~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{table}~~\Tid'~~\Taddrtype^?~~n~~n~~\Treftype~\text{)} \\ & \qquad
       \text{(}~\text{elem}~~\text{(}~\text{table}~~\Tid'~\text{)}~~\text{(}~\Taddrtype'\text{.const}~~\text{0}~\text{)}~~\Treftype~~\Tlist(\Telemexpr)~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh, \\ & \qquad\qquad
        \iff \Taddrtype? \neq \epsilon \wedge \Taddrtype' = \Taddrtype^? \vee \Taddrtype^? = \epsilon \wedge \Taddrtype' = \text{i32}) \\
   \end{array}

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\Taddrtype^?~~\Treftype~~\text{(}~\text{elem}~~x^n{:}\Tlist(\Tfuncidx)~\text{)}~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{table}~~\Tid'~~\Taddrtype^?~~n~~n~~\Treftype~\text{)} \\ & \qquad
       \text{(}~\text{elem}~~\text{(}~\text{table}~~\Tid'~\text{)}~~\text{(}~\Taddrtype'\text{.const}~~\text{0}~\text{)}~~\Treftype~~\Tlist(\text{(}~\text{ref.func}~~\Tfuncidx~\text{)})~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh, \\ & \qquad\qquad
        \iff \Taddrtype? \neq \epsilon \wedge \Taddrtype' = \Taddrtype^? \vee \Taddrtype^? = \epsilon \wedge \Taddrtype' = \text{i32}) \\
   \end{array}

Tables can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{table}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Ttabletype~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{table}~~\Tid^?~~\Ttabletype~\text{)}~\text{)} \\[1ex] &
     \text{(}~\text{table}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{table}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{table}~~\Tid'~~\dots~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. note::
   The latter abbreviation can be applied repeatedly, if ":math:`\dots`" contains additional export clauses.
   Consequently, a table declaration can contain any number of exports, possibly followed by an import.


.. index:: function, type index, function type, identifier, local
   pair: text format; function
   pair: text format; local
.. _text-local:
.. _text-func:

Functions
~~~~~~~~~

Function definitions can bind a symbolic :ref:`function identifier <text-id>`, and :ref:`local identifiers <text-id>` for its :ref:`parameters <text-typeuse>` and locals.

.. math::
   \begin{array}{llclll}
   \production{function} & \Tfunc_I &::=&
     \text{(}~\text{func}~~\Tid^?~~x,I'{:}\Ttypeuse_I~~
     (\X{loc}{:}\Tlocal_I)^\ast~~(\X{in}{:}\Tinstr_{I''})^\ast~\text{)} \\ &&& \qquad
       \Rightarrow\quad \FUNC~x~\X{loc}^\ast~\X{in}^\ast \\ &&& \qquad\qquad\qquad
       (\iff I'' = I \compose I' \compose \{\ILOCALS~\F{id}(\Tlocal)^\ast\} \idcwellformed) \\[1ex]
   \production{local} & \Tlocal_I &::=&
     \text{(}~\text{local}~~\Tid^?~~t{:}\Tvaltype_I~\text{)}
       \quad\Rightarrow\quad \LOCAL~t \\
   \end{array}

The definition of the local :ref:`identifier context <text-context>` :math:`I''` uses the following auxiliary function to extract optional identifiers from locals:

.. math::
   \begin{array}{lcl@{\qquad\qquad}l}
   \F{id}(\text{(}~\text{local}~\Tid^?~\dots~\text{)}) &=& \Tid^? \\
   \end{array}


.. note::
   The :ref:`well-formedness <text-context-wf>` condition on :math:`I''` ensures that parameters and locals do not contain duplicate identifiers.


.. index:: import, name
   pair: text format; import
.. index:: export, name, index, function index
   pair: text format; export
.. _text-func-abbrev:

Abbreviations
.............

Multiple anonymous locals may be combined into a single declaration:

.. math::
   \begin{array}{llclll}
   \production{local} &
     \text{(}~~\text{local}~~\Tvaltype^\ast~~\text{)} &\equiv&
     (\text{(}~~\text{local}~~\Tvaltype~~\text{)})^\ast \\
   \end{array}

Functions can be defined as :ref:`imports <text-import>` or :ref:`exports <text-export>` inline:

.. math::
   \begin{array}{llclll}
   \production{module field} &
     \text{(}~\text{func}~~\Tid^?~~\text{(}~\text{import}~~\Tname_1~~\Tname_2~\text{)}~~\Ttypeuse~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{import}~~\Tname_1~~\Tname_2~~\text{(}~\text{func}~~\Tid^?~~\Ttypeuse~\text{)}~\text{)} \\[1ex] &
     \text{(}~\text{func}~~\Tid^?~~\text{(}~\text{export}~~\Tname~\text{)}~~\dots~\text{)} \quad\equiv \\ & \qquad
       \text{(}~\text{export}~~\Tname~~\text{(}~\text{func}~~\Tid'~\text{)}~\text{)}~~
       \text{(}~\text{func}~~\Tid'~~\dots~\text{)}
       \\ & \qquad\qquad
       (\iff \Tid^? \neq \epsilon \wedge \Tid' = \Tid^? \vee \Tid^? = \epsilon \wedge \Tid' \idfresh) \\
   \end{array}

.. note::
   The latter abbreviation can be applied repeatedly, if ":math:`\dots`" contains additional export clauses.
   Consequently, a function declaration can contain any number of exports, possibly followed by an import.


.. index:: data, memory, memory index, expression, byte
   pair: text format; data
   single: memory; data
   single: data; segment
.. _text-datastring:
.. _text-data:
.. _text-memuse:

Data Segments
~~~~~~~~~~~~~

Data segments allow for an optional :ref:`memory index <text-memidx>` to identify the memory to initialize.
The data is written as a :ref:`string <text-string>`, which may be split up into a possibly empty sequence of individual string literals.

.. math::
   \begin{array}{llclll}
   \production{data segment} & \Tdata_I &::=&
     \text{(}~\text{data}~~\Tid^?~~b^\ast{:}\Tdatastring~\text{)} \\ &&& \qquad
       \Rightarrow\quad \DATA~b^\ast~\DPASSIVE \\ &&|&
     \text{(}~\text{data}~~\Tid^?~~x{:}\Tmemuse_I~~\text{(}~\text{offset}~~e{:}\Texpr_I~\text{)}~~b^\ast{:}\Tdatastring~\text{)} \\ &&& \qquad
       \Rightarrow\quad \DATA~b^\ast~\DACTIVE~x~e \\
   \production{data string} & \Tdatastring &::=&
     (b^\ast{:}\Tstring)^\ast \quad\Rightarrow\quad \concat((b^\ast)^\ast) \\
   \production{memory use} & \Tmemuse_I &::=&
     \text{(}~\text{memory}~~x{:}\Tmemidx_I ~\text{)}
       \quad\Rightarrow\quad x \\
   \end{array}

.. note::
   In the current version of WebAssembly, the only valid memory index is 0
   or a symbolic :ref:`memory identifier <text-id>` resolving to the same value.


Abbreviations
.............

As an abbreviation, a single :ref:`folded instruction <text-foldedinstr>` may occur in place of the offset of an active data segment:

.. math::
   \begin{array}{llcll}
   \production{data offset} &
     \text{(}~\Tfoldedinstr~\text{)} &\equiv&
     \text{(}~\text{offset}~~\Tinstr~\text{)}
   \end{array}

Also, a memory use can be omitted, defaulting to :math:`\T{0}`.

.. math::
   \begin{array}{llclll}
   \production{memory use} &
     \epsilon &\equiv& \text{(}~\text{memory}~~\text{0}~\text{)} \\
   \end{array}

As another abbreviation, data segments may also be specified inline with :ref:`memory <text-mem>` definitions; see the respective section.


.. index:: element, table index, expression, function index
   pair: text format; element
   single: table; element
   single: element; segment
.. _text-elem:
.. _text-elemlist:
.. _text-elemexpr:
.. _text-tableuse:

Element Segments
~~~~~~~~~~~~~~~~

Element segments allow for an optional :ref:`table index <text-tableidx>` to identify the table to initialize.

.. math::
   \begin{array}{llclll}
   \production{element segment} & \Telem_I &::=&
     \text{(}~\text{elem}~~\Tid^?~~(et, e^\ast){:}\Telemlist_I~\text{)} \\ &&& \qquad
       \Rightarrow\quad \ELEM~et~e^\ast~\EPASSIVE \\ &&|&
     \text{(}~\text{elem}~~\Tid^?~~x{:}\Ttableuse_I~~\text{(}~\text{offset}~~e'{:}\Texpr_I~\text{)}~~(et, e^\ast){:}\Telemlist_I~\text{)} \\ &&& \qquad
       \Rightarrow\quad \ELEM~et~e^\ast~\EACTIVE~~x~e' \\ &&&
     \text{(}~\text{elem}~~\Tid^?~~\text{declare}~~(et, y^\ast){:}\Telemlist_I~\text{)} \\ &&& \qquad
       \Rightarrow\quad \ELEM~et~e^\ast~\EDECLARE \\
   \production{element list} & \Telemlist_I &::=&
     t{:}\Treftype_I~~e^\ast{:}\Tlist(\Telemexpr_I) \qquad\Rightarrow\quad ( t, ee^\ast ) \\
   \production{element expression} & \Telemexpr_I &::=&
     \text{(}~\text{item}~~e{:}\Texpr_I~\text{)}
       \quad\Rightarrow\quad e \\
   \production{table use} & \Ttableuse_I &::=&
     \text{(}~\text{table}~~x{:}\Ttableidx_I ~\text{)}
       \quad\Rightarrow\quad x \\
   \end{array}


Abbreviations
.............

As an abbreviation, a single :ref:`folded instruction <text-foldedinstr>` may occur in place of the offset of an active element segment or as an element expression:

.. math::
   \begin{array}{llcll}
   \production{element offset} &
     \text{(}~\Tfoldedinstr~\text{)} &\equiv&
     \text{(}~\text{offset}~~\Tinstr~\text{)} \\
   \production{element item} &
     \text{(}~\Tfoldedinstr~\text{)} &\equiv&
     \text{(}~\text{item}~~\Tinstr~\text{)} \\
   \end{array}

Also, the element list may be written as just a sequence of :ref:`function indices <text-funcidx>`:

.. math::
   \begin{array}{llcll}
   \production{element list} &
     \text{func}~~\Tlist(\Tfuncidx_I) &\equiv&
     \text{(ref}~\text{func)}~~\Tlist(\text{(}~\text{ref.func}~~\Tfuncidx_I~\text{)})
   \end{array}

A table use can be omitted, defaulting to :math:`\T{0}`.
Furthermore, for backwards compatibility with earlier versions of WebAssembly, if the table use is omitted, the :math:`\text{func}` keyword can be omitted as well.

.. math::
   \begin{array}{llclll}
   \production{table use} &
     \epsilon &\equiv& \text{(}~\text{table}~~\text{0}~\text{)} \\
   \production{element segment} &
     \text{(}~\text{elem}~~\Tid^?~~\text{(}~\text{offset}~~\Texpr_I~\text{)}~~\\ &
     \qquad \Tlist(\Tfuncidx_I)~\text{)}
       &\equiv&
     \text{(}~\text{elem}~~\Tid^?~~\text{(}~\text{table}~~\text{0}~\text{)}~~\text{(}~\text{offset}~~\Texpr_I~\text{)}~~\\ &
     &&\qquad \text{func}~~\Tlist(\Tfuncidx_I)~\text{)}
   \end{array}

As another abbreviation, element segments may also be specified inline with :ref:`table <text-table>` definitions; see the respective section.


.. index:: start function, function index
   pair: text format; start function
.. _text-start:

Start Function
~~~~~~~~~~~~~~

A :ref:`start function <syntax-start>` is defined in terms of its index.

.. math::
   \begin{array}{llclll}
   \production{start function} & \Tstart_I &::=&
     \text{(}~\text{start}~~x{:}\Tfuncidx_I~\text{)}
       &\Rightarrow& \START~x \\
   \end{array}

.. note::
   At most one start function may occur in a module,
   which is ensured by a suitable side condition on the |Tmodule| grammar.



.. index:: import, name, tag type, global type, memory type, table type, function type
   pair: text format; import
.. _text-import:

Imports
~~~~~~~

The :ref:`external type <syntax-externtype>` in imports can bind a symbolic tag, global, memory, or function :ref:`identifier <text-id>`.

.. math::
   \begin{array}{llclll}
   \production{import} & \Timport_I &::=&
     \text{(}~\text{import}~~\X{nm}_1{:}\Tname~~\X{nm}_2{:}\Tname~~\X{xx}{:}\Texterntype_I~\text{)} \\ &&& \qquad
       \Rightarrow\quad \IMPORT~\X{nm}_1~\X{nm}_2~\X{xx} \\[1ex]
   \end{array}


Abbreviations
.............

As an abbreviation, imports may also be specified inline with
:ref:`tag <text-tag>`,
:ref:`global <text-global>`,
:ref:`memory <text-mem>`,
:ref:`table <text-table>`, or
:ref:`function <text-func>`
definitions; see the respective sections.



.. index:: export, name, index, external index, tag index, global index, memory index, table index, function index
   pair: text format; export
.. _text-externidx:
.. _text-export:

Exports
~~~~~~~

The syntax for exports mirrors their :ref:`abstract syntax <syntax-export>` directly.

.. math::
   \begin{array}{llclll}
   \production{export} & \Texport_I &::=&
     \text{(}~\text{export}~~\X{nm}{:}\Tname~~\X{xx}{:}\Texternidx_I~\text{)}
       &\Rightarrow& \EXPORT~\X{nm}~\X{xx} \} \\
   \production{external index} & \Texternidx_I &::=&
     \text{(}~\text{tag}~~x{:}\Ttagidx_I~\text{)}
       &\Rightarrow& \XXTAG~x \\ &&|&
     \text{(}~\text{global}~~x{:}\Tglobalidx_I~\text{)}
       &\Rightarrow& \XXGLOBAL~x \\&&|&
     \text{(}~\text{memory}~~x{:}\Tmemidx_I~\text{)}
       &\Rightarrow& \XXMEM~x \\ &&|&
     \text{(}~\text{table}~~x{:}\Ttableidx_I~\text{)}
       &\Rightarrow& \XXTABLE~x \\ &&|&
     \text{(}~\text{func}~~x{:}\Tfuncidx_I~\text{)}
       &\Rightarrow& \XXFUNC~x \\
   \end{array}


Abbreviations
.............

As an abbreviation, exports may also be specified inline with
:ref:`tag <text-tag>`,
:ref:`global <text-global>`,
:ref:`memory <text-mem>`,
:ref:`table <text-table>`, or
:ref:`function <text-func>`
definitions; see the respective sections.


.. index:: module, type definition, recursive type, tag, global, memory, table, function, data segment, element segment, start function, import, export, identifier context, identifier, name section
   pair: text format; module
   single: section; name
.. _text-modulefield:
.. _text-module:

Modules
~~~~~~~

A module consists of a sequence of fields that can occur in any order.
All definitions and their respective bound :ref:`identifiers <text-id>` scope over the entire module, including the text preceding them.

A module may optionally bind an :ref:`identifier <text-id>` that names the module.
The name serves a documentary role only.

.. note::
   Tools may include the module name in the :ref:`name section <binary-namesec>` of the :ref:`binary format <binary>`.

.. math::
   \begin{array}{lll}
   \production{module} & \Tmodule &
   \begin{array}[t]{@{}cllll}
   ::=&
     \text{(}~\text{module}~~\Tid^?~~(m{:}\Tmodulefield_I)^\ast~\text{)}
       \quad\Rightarrow\quad \bigcompose m^\ast \\
       &\qquad (\iff I = \bigcompose \F{idc}(\Tmodulefield)^\ast \idcwellformed) \\
   \end{array} \\[1ex]
   \production{module field} & \Tmodulefield_I &
   \begin{array}[t]{@{}clll}
   ::=&
     \X{ty}^\ast{:}\Trectype_I &\Rightarrow& \MODULE~\X{ty}^\ast \\ |&
     \X{im}{:}\Timport_I &\Rightarrow& \MODULE~\X{im} \\ |&
     \X{tg}{:}\Ttag_I &\Rightarrow& \MODULE~\X{tg} \\ |&
     \X{gl}{:}\Tglobal_I &\Rightarrow& \MODULE~\X{gl} \\ |&
     \X{me}{:}\Tmem_I &\Rightarrow& \MODULE~\X{me} \\ |&
     \X{ta}{:}\Ttable_I &\Rightarrow& \MODULE~\X{ta} \\ |&
     \X{fn}{:}\Tfunc_I &\Rightarrow& \MODULE~\X{fn} \\ |&
     \X{da}{:}\Tdata_I &\Rightarrow& \MODULE~\X{da} \\ |&
     \X{el}{:}\Telem_I &\Rightarrow& \MODULE~\X{el} \\ |&
     \X{st}{:}\Tstart_I &\Rightarrow& \MODULE~\X{st} \\ |&
     \X{ex}{:}\Texport_I &\Rightarrow& \MODULE~\X{ex} \\
   \end{array}
   \end{array}

where :math:`\bigcompose m^\ast` is the :ref:`module <syntax-module>` formed by the repeated concatenation of the indivual field sequences in order.
The following restrictions are imposed on this composition: :math:`m_1 \compose m_2` is defined if and only if

* :math:`\start_1^? = \epsilon \vee \start_2^? = \epsilon`

* :math:`\tag_1^\ast = \global_1^\ast = \mem_1^\ast = \table_1^\ast = \func_1^\ast = \epsilon \vee \import_2^\ast = \epsilon`

.. note::
   The first condition ensures that there is at most one start function.
   The second condition enforces that all :ref:`imports <text-import>` must occur before any regular definition of a
   :ref:`tag <text-tag>`,
   :ref:`global <text-global>`,
   :ref:`memory <text-mem>`,
   :ref:`table <text-table>`, or
   :ref:`function <text-func>`,
   thereby maintaining the ordering of the respective :ref:`index spaces <syntax-index>`.

   The :ref:`well-formedness <text-context-wf>` condition on :math:`I` in the grammar for |Tmodule| ensures that no namespace contains duplicate identifiers.

The definition of the initial :ref:`identifier context <text-context>` :math:`I` uses the following auxiliary definition which maps each relevant definition to a singular context with one (possibly empty) identifier:

.. math::
   \begin{array}{@{}lcl@{\qquad\qquad}l}
   \F{idc}(\text{(}~\text{rec}~~\Ttypedef^\ast~\text{)}) &=&
     \bigcompose \F{idc}(\Ttypedef)^\ast \\
   \F{idc}(\text{(}~\text{type}~v^?{:}\Tid^?~\Tsubtype~\text{)}) &=&
     \{\ITYPES~(v^?), \IFIELDS~\F{idf}(\Tsubtype), \ITYPEDEFS~\X{st}\} \\
   \F{idc}(\text{(}~\text{tag}~v^?{:}\Tid^?~\dots~\text{)}) &=&
     \{\ITAGS~(v^?)\} \\
   \F{idc}(\text{(}~\text{global}~v^?{:}\Tid^?~\dots~\text{)}) &=&
     \{\IGLOBALS~(v^?)\} \\
   \F{idc}(\text{(}~\text{memory}~v^?{:}\Tid^?~\dots~\text{)}) &=&
     \{\IMEMS~(v^?)\} \\
   \F{idc}(\text{(}~\text{table}~v^?{:}\Tid^?~\dots~\text{)}) &=&
     \{\ITABLES~(v^?)\} \\
   \F{idc}(\text{(}~\text{func}~v^?{:}\Tid^?~\dots~\text{)}) &=&
     \{\IFUNCS~(v^?)\} \\
   \F{idc}(\text{(}~\text{data}~v^?{:}\Tid^?~\dots~\text{)}) &=&
     \{\IDATAS~(v^?)\} \\
   \F{idc}(\text{(}~\text{elem}~v^?{:}\Tid^?~\dots~\text{)}) &=&
     \{\IELEMS~(v^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{func}~v^?{:}\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\IFUNCS~(v^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{table}~v^?{:}\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\ITABLES~(v^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{memory}~v^?{:}\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\IMEMS~(v^?)\} \\
   \F{idc}(\text{(}~\text{import}~\dots~\text{(}~\text{global}~v^?{:}\Tid^?~\dots~\text{)}~\text{)}) &=&
     \{\IGLOBALS~(v^?)\} \\
   \F{idc}(\text{(}~\dots~\text{)}) &=&
     \{\}
   \\[2ex]
   \F{idf}(\text{(}~\text{sub}~\dots~\Tcomptype~\text{)}) &=&
     \F{idf}(\Tcomptype) \\
   \F{idf}(\text{(}~\text{struct}~\X{Tfield}^\ast~\text{)}) &=&
     \bigcompose \F{idf}(\Tfield)^\ast \\
   \F{idf}(\text{(}~\text{array}~\dots~\text{)}) &=&
     \epsilon \\
   \F{idf}(\text{(}~\text{func}~\dots~\text{)}) &=&
     \epsilon \\
   \F{idf}(\text{(}~\text{field}~v^?{:}\Tid^?~\dots~\text{)}) &=&
     v^? \\
   \end{array}


Abbreviations
.............

In a source file, the toplevel :math:`\T{(module}~\dots\T{)}` surrounding the module body may be omitted.

.. math::
   \begin{array}{llcll}
   \production{module} &
     \Tmodulefield^\ast &\equiv&
     \text{(}~\text{module}~~\Tmodulefield^\ast~\text{)}
   \end{array}
