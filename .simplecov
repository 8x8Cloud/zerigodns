SimpleCov.start do
  add_filter do |src|
    (src.filename =~ /^#{SimpleCov.root}\/spec/)
  end
end
