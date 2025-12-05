require_relative 'spec_helper'

RSpec.describe 'Academic Journey Path Verification' do
  before(:all) do
    @site_dir = File.expand_path('../_site', __dir__)
    
    unless Dir.exist?(@site_dir)
      puts "\n⚠️  Warning: _site directory not found. Please run 'bundle exec jekyll build' first.\n\n"
      skip "Site not built. Run 'bundle exec jekyll build' first."
    end
  end

  describe 'Academic journey pages exist' do
    it 'has a Publications page' do
      publications_path = File.join(@site_dir, 'publications', 'index.html')
      expect(File.exist?(publications_path)).to be(true), "Publications page not found at #{publications_path}"
    end

    it 'has an Academic CV page' do
      cv_path = File.join(@site_dir, 'academic-cv', 'index.html')
      expect(File.exist?(cv_path)).to be(true), "Academic CV page not found at #{cv_path}"
    end

    it 'has an About page' do
      about_path = File.join(@site_dir, 'about', 'index.html')
      expect(File.exist?(about_path)).to be(true), "About page not found at #{about_path}"
    end
  end

  describe 'Academic journey content verification' do
    it 'Publications page contains categorized sections' do
      publications_path = File.join(@site_dir, 'publications', 'index.html')
      content = File.read(publications_path)
      doc = Nokogiri::HTML(content)
      
      # Check for key sections
      expect(content).to include('Peer-Reviewed Papers'), 'Publications page should have Peer-Reviewed Papers section'
      expect(content).to include('Workshop Publications'), 'Publications page should have Workshop Publications section'
      expect(content).to include('Datasets'), 'Publications page should have Datasets section'
      expect(content).to include('Thesis'), 'Publications page should have Thesis section'
    end

    it 'Academic CV page has PDF download button' do
      cv_path = File.join(@site_dir, 'academic-cv', 'index.html')
      content = File.read(cv_path)
      doc = Nokogiri::HTML(content)
      
      # Check for download button
      download_link = doc.css('a[href*="Abdul_Meque_Academic_CV.pdf"]').first
      expect(download_link).not_to be_nil, 'Academic CV should have a PDF download link'
      expect(download_link.text).to include('Download'), 'Download button should contain "Download" text'
    end

    it 'Academic CV page contains key sections' do
      cv_path = File.join(@site_dir, 'academic-cv', 'index.html')
      content = File.read(cv_path)
      
      # Check for key CV sections
      expect(content).to include('Education'), 'CV should have Education section'
      expect(content).to include('Research Experience'), 'CV should have Research Experience section'
      expect(content).to include('Publications'), 'CV should have Publications section'
      expect(content).to include('Teaching Experience'), 'CV should have Teaching Experience section'
      expect(content).to include('Technical Skills'), 'CV should have Technical Skills section'
    end

    it 'About page links to My Story' do
      about_path = File.join(@site_dir, 'about', 'index.html')
      content = File.read(about_path)
      doc = Nokogiri::HTML(content)
      
      # Check for My Story link
      my_story_link = doc.css('a[href*="my-story"]').first
      expect(my_story_link).not_to be_nil, 'About page should link to My Story'
      expect(my_story_link.text).to include('My Story'), 'Link text should mention My Story'
    end

    it 'About page contains professional summary' do
      about_path = File.join(@site_dir, 'about', 'index.html')
      content = File.read(about_path)
      
      # Check for key content
      expect(content).to include('Executive Summary'), 'About page should have Executive Summary'
      expect(content).to include('Journey'), 'About page should have Journey section'
      expect(content).to include('Current Focus'), 'About page should have Current Focus section'
    end
  end

  describe 'Academic journey navigation flow' do
    it 'verifies the complete academic journey path exists' do
      # Home → Publications → Academic CV → About
      pages = [
        File.join(@site_dir, 'index.html'),
        File.join(@site_dir, 'publications', 'index.html'),
        File.join(@site_dir, 'academic-cv', 'index.html'),
        File.join(@site_dir, 'about', 'index.html')
      ]
      
      pages.each do |page_path|
        expect(File.exist?(page_path)).to be(true), "Page not found: #{page_path}"
      end
    end

    it 'verifies navigation menu is present on academic pages' do
      academic_pages = [
        File.join(@site_dir, 'publications', 'index.html'),
        File.join(@site_dir, 'academic-cv', 'index.html'),
        File.join(@site_dir, 'about', 'index.html')
      ]
      
      academic_pages.each do |page_path|
        content = File.read(page_path)
        doc = Nokogiri::HTML(content)
        
        # Check for navigation links
        nav_links = doc.css('nav a, .masthead a')
        expect(nav_links.length).to be > 0, "Navigation should be present on #{page_path}"
        
        # Check for key navigation items
        nav_text = nav_links.map(&:text).join(' ')
        expect(nav_text).to include('Publications'), "Navigation should include Publications link on #{page_path}"
        expect(nav_text).to include('Academic CV'), "Navigation should include Academic CV link on #{page_path}"
      end
    end
  end
end
