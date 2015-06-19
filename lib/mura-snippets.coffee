MuraSnippetsView = require './mura-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = MuraSnippets =
  muraSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @muraSnippetsView = new MuraSnippetsView(state.muraSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @muraSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'mura-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @muraSnippetsView.destroy()

  serialize: ->
    muraSnippetsViewState: @muraSnippetsView.serialize()

  toggle: ->
    console.log 'MuraSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
