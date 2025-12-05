require_relative 'spec_helper'
require 'fileutils'
require 'tmpdir'

# **Feature: professional-website-redesign, Property 9: Build stability**
# **Validates: Requirements 9.2**
#
# Property: For any valid configuration change in _config.yml, the Jekyll build should complete 
# successfully without errors and all existing pages should remain accessible.

RSpec.describe 'Build Stability Property Test' do
  let(:project_root) { File.expand_path('..', __dir__) }
  let(:config_file) { File.join(project_root, '_config.yml') }
  let(:original_config) { File.read(config_file) }
  let(:site_dir) { File.join(project_root, '_site') }

  # Helper method to get all existing page URLs before config change
  def get_existing_pages(site_dir)
    return [] unless Dir.exist?(site_dir)
    
    html_files = Dir.glob(File.join(site_dir, '**', '*.html'))
    html_files.map { |f| f.sub(site_dir, '').sub(/\/index\.html$/, '/').sub(/\.html$/, '') }
  end

  # Helper method to build Jekyll site
  def build_jekyll_site(project_root)
    Dir.chdir(project_root) do
      # Capture both stdout and stderr
      output = `bundle exec jekyll build 2>&1`
      success = $?.success?
      { success: success, output: output }
    end
  end

  # Helper method to restore original config
  def restore_config(config_file, original_config)
    File.write(config_file, original_config)
  end

  before(:all) do
    # Ensure the site is built initially
    project_root = File.expand_path('..', __dir__)
    unless Dir.exist?(File.join(project_root, '_site'))
      puts "Building Jekyll site for testing..."
      Dir.chdir(project_root) do
        system('bundle exec jekyll build')
      end
    end
  end

  after(:each) do
    # Always restore original config after each test
    restore_config(config_file, original_config)
  end

  describe 'Property: Build stability with configuration changes' do
    it 'verifies Jekyll builds successfully with valid config changes (property-based test)' do
      # Get list of existing pages before any changes
      initial_pages = get_existing_pages(site_dir)
      
      # Skip if no pages found
      skip "No pages found in _site directory" if initial_pages.empty?

      # Property-based test: run 100 iterations as specified in design doc
      property_of {
        # Generator: Create random valid configuration changes
        # We'll modify safe, commonly-changed fields that shouldn't break the build
        
        config_change_type = choose(
          :title,
          :subtitle,
          :description,
          :author_name,
          :author_bio,
          :author_location,
          :locale,
          :timezone,
          :words_per_minute
        )
        
        new_value = case config_change_type
        when :title
          "Test Site #{rand(1000)}"
        when :subtitle
          choose(
            "AI Consultant · Researcher",
            "Cloud Architect · Writer",
            "Applied Researcher · Consultant · Writer",
            "Technology Leader · AI Specialist"
          )
        when :description
          "Test description #{rand(1000)}"
        when :author_name
          "Test Author #{rand(100)}"
        when :author_bio
          "Test bio #{rand(100)}"
        when :author_location
          choose("Mexico City", "New York", "London", "Tokyo", "Berlin")
        when :locale
          choose("en-US", "en-GB", "es-MX", "pt-BR")
        when :timezone
          choose("America/Mexico_City", "America/New_York", "Europe/London", "Asia/Tokyo")
        when :words_per_minute
          range(100, 250)
        end
        
        { type: config_change_type, value: new_value }
      }.check(100) do |change|
        # Load the original config
        config_data = YAML.load_file(config_file)
        
        # Apply the configuration change
        case change[:type]
        when :title
          config_data['title'] = change[:value]
        when :subtitle
          config_data['subtitle'] = change[:value]
        when :description
          config_data['description'] = change[:value]
        when :author_name
          config_data['author']['name'] = change[:value]
        when :author_bio
          config_data['author']['bio'] = change[:value]
        when :author_location
          config_data['author']['location'] = change[:value]
        when :locale
          config_data['locale'] = change[:value]
        when :timezone
          config_data['timezone'] = change[:value]
        when :words_per_minute
          config_data['words_per_minute'] = change[:value]
        end
        
        # Write the modified config
        File.write(config_file, YAML.dump(config_data))
        
        # Build the site
        result = build_jekyll_site(project_root)
        
        # Restore original config immediately after build
        restore_config(config_file, original_config)
        
        # Verify the build succeeded
        expect(result[:success]).to be(true),
          "Jekyll build failed with config change #{change[:type]} = #{change[:value]}. Output: #{result[:output]}"
        
        # Verify all existing pages are still accessible
        new_pages = get_existing_pages(site_dir)
        
        # Check that all initial pages still exist
        missing_pages = initial_pages - new_pages
        expect(missing_pages).to be_empty,
          "Pages became inaccessible after config change #{change[:type]} = #{change[:value]}: #{missing_pages.join(', ')}"
      end
    end
  end

  describe 'Unit tests for specific configuration changes' do
    it 'builds successfully when changing site title' do
      config_data = YAML.load_file(config_file)
      config_data['title'] = 'Test Site Title'
      File.write(config_file, YAML.dump(config_data))
      
      result = build_jekyll_site(project_root)
      
      expect(result[:success]).to be(true),
        "Jekyll build failed when changing title. Output: #{result[:output]}"
    end

    it 'builds successfully when changing author information' do
      config_data = YAML.load_file(config_file)
      config_data['author']['name'] = 'Test Author'
      config_data['author']['bio'] = 'Test bio'
      config_data['author']['location'] = 'Test Location'
      File.write(config_file, YAML.dump(config_data))
      
      result = build_jekyll_site(project_root)
      
      expect(result[:success]).to be(true),
        "Jekyll build failed when changing author info. Output: #{result[:output]}"
    end

    it 'builds successfully when changing locale and timezone' do
      config_data = YAML.load_file(config_file)
      config_data['locale'] = 'en-GB'
      config_data['timezone'] = 'Europe/London'
      File.write(config_file, YAML.dump(config_data))
      
      result = build_jekyll_site(project_root)
      
      expect(result[:success]).to be(true),
        "Jekyll build failed when changing locale/timezone. Output: #{result[:output]}"
    end
  end

  describe 'Edge cases' do
    it 'handles empty string values gracefully' do
      config_data = YAML.load_file(config_file)
      config_data['subtitle'] = ''
      File.write(config_file, YAML.dump(config_data))
      
      result = build_jekyll_site(project_root)
      
      # Build should still succeed even with empty subtitle
      expect(result[:success]).to be(true),
        "Jekyll build failed with empty subtitle. Output: #{result[:output]}"
    end

    it 'preserves existing pages after multiple config changes' do
      initial_pages = get_existing_pages(site_dir)
      
      # Make multiple changes
      3.times do |i|
        config_data = YAML.load_file(config_file)
        config_data['title'] = "Test Title #{i}"
        File.write(config_file, YAML.dump(config_data))
        
        result = build_jekyll_site(project_root)
        expect(result[:success]).to be(true)
      end
      
      # Verify pages still exist
      final_pages = get_existing_pages(site_dir)
      missing_pages = initial_pages - final_pages
      
      expect(missing_pages).to be_empty,
        "Pages became inaccessible after multiple config changes: #{missing_pages.join(', ')}"
    end
  end
end
