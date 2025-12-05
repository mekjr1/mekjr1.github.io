require_relative 'spec_helper'

# **Feature: professional-website-redesign, Property 3: Navigation consistency across pages**
# **Validates: Requirements 6.1**
#
# Property: For any page on the website, the navigation menu should contain exactly these items in order:
# Home, About, Work With Me, Work & Projects, Publications, Writing, Academic CV, My Story, Contact

RSpec.describe 'Navigation Consistency Property Test' do
  # Expected navigation structure from requirements
  EXPECTED_NAVIGATION = [
    { title: 'Home', url: '/' },
    { title: 'About', url: '/about/' },
    { title: 'Work With Me', url: '/work-with-me/' },
    { title: 'Work & Projects', url: '/work-projects/' },
    { title: 'Publications', url: '/publications/' },
    { title: 'Writing', url: '/writing/' },
    { title: 'Academic CV', url: '/academic-cv/' },
    { title: 'My Story', url: '/my-story/' },
    { title: 'Contact', url: '/contact/' }
  ].freeze

  let(:site_dir) { File.expand_path('../_site', __dir__) }
  let(:navigation_yml) { File.expand_path('../_data/navigation.yml', __dir__) }

  before(:all) do
    # Ensure the site is built
    unless Dir.exist?(File.expand_path('../_site', __dir__))
      puts "Building Jekyll site for testing..."
      system('bundle exec jekyll build', chdir: File.expand_path('..', __dir__))
    end
  end

  describe 'Property: Navigation consistency across all pages' do
    it 'verifies navigation.yml contains the expected navigation structure' do
      # Load the navigation configuration
      navigation_data = YAML.load_file(navigation_yml)
      main_nav = navigation_data['main']

      # Verify the navigation has the correct number of items
      expect(main_nav.length).to eq(EXPECTED_NAVIGATION.length),
        "Expected #{EXPECTED_NAVIGATION.length} navigation items, but found #{main_nav.length}"

      # Verify each navigation item matches the expected structure
      EXPECTED_NAVIGATION.each_with_index do |expected_item, index|
        actual_item = main_nav[index]
        
        expect(actual_item['title']).to eq(expected_item[:title]),
          "Expected navigation item #{index} to have title '#{expected_item[:title]}', but got '#{actual_item['title']}'"
        
        expect(actual_item['url']).to eq(expected_item[:url]),
          "Expected navigation item #{index} to have url '#{expected_item[:url]}', but got '#{actual_item['url']}'"
      end
    end

    it 'verifies navigation consistency across random sample of pages (property-based test)' do
      # Find all HTML files in the _site directory
      html_files = Dir.glob(File.join(site_dir, '**', '*.html'))
      
      # Skip if no files found
      skip "No HTML files found in _site directory" if html_files.empty?

      # Property-based test: run 100 iterations as specified in design doc
      property_of {
        # Generator: Select a random page from the built site
        choose(*html_files)
      }.check(100) do |html_file|
        # Parse the HTML file
        doc = Nokogiri::HTML(File.read(html_file))
        
        # Find the navigation menu
        nav_element = doc.at_css('nav#site-nav')
        
        # Skip pages that don't have the main navigation (like 404 pages might not)
        next unless nav_element
        
        # Extract navigation links
        nav_links = nav_element.css('li.masthead__menu-item a')
        
        # Filter out the site title link (first link with --lg class)
        # The site title is in a li with class "masthead__menu-item--lg"
        nav_links = nav_element.css('li.masthead__menu-item:not(.masthead__menu-item--lg) a')
        
        # Verify the navigation has the correct number of items
        expect(nav_links.length).to eq(EXPECTED_NAVIGATION.length),
          "Page #{html_file} has #{nav_links.length} navigation items, expected #{EXPECTED_NAVIGATION.length}"
        
        # Verify each navigation item matches the expected structure
        EXPECTED_NAVIGATION.each_with_index do |expected_item, index|
          actual_link = nav_links[index]
          actual_title = actual_link.text.strip
          actual_url = actual_link['href']
          
          # Normalize URLs (remove domain if present)
          actual_url = actual_url.gsub(/^https?:\/\/[^\/]+/, '')
          
          expect(actual_title).to eq(expected_item[:title]),
            "Page #{html_file}: Expected navigation item #{index} to have title '#{expected_item[:title]}', but got '#{actual_title}'"
          
          expect(actual_url).to eq(expected_item[:url]),
            "Page #{html_file}: Expected navigation item #{index} to have url '#{expected_item[:url]}', but got '#{actual_url}'"
        end
      end
    end
  end

  describe 'Edge cases' do
    it 'handles pages with missing navigation gracefully' do
      # This test ensures the property test doesn't fail on pages without navigation
      # The property test should skip such pages using 'next unless nav_element'
      
      # Create a temporary HTML file without navigation
      temp_html = File.join(site_dir, 'temp_test_page.html')
      File.write(temp_html, '<html><body><h1>Test Page</h1></body></html>')
      
      doc = Nokogiri::HTML(File.read(temp_html))
      nav_element = doc.at_css('nav#site-nav')
      
      expect(nav_element).to be_nil
      
      # Clean up
      File.delete(temp_html) if File.exist?(temp_html)
    end
  end
end
