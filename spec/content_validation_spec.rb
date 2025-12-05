require_relative 'spec_helper'

RSpec.describe 'Content Validation and Testing' do
  before(:all) do
    # Check if site is built
    unless Dir.exist?('_site')
      puts "\n⚠️  Site not built. Building now..."
      system('bundle exec jekyll build')
    end
  end

  describe 'Homepage Content' do
    let(:homepage) { File.read('_site/index.html') }
    let(:homepage_doc) { Nokogiri::HTML(homepage) }

    it 'contains the professional tagline' do
      expect(homepage).to include('AI Consultant · Cloud Architect · Applied Researcher · Writer')
    end

    it 'contains the subtitle about geographic reach' do
      expect(homepage).to include('From Mozambique to Mexico and globally')
    end

    it 'has primary CTA button linking to Work With Me' do
      work_with_me_link = homepage_doc.css('a[href="/work-with-me/"]').find do |link|
        link.text.strip.match?(/Work With Me/i)
      end
      expect(work_with_me_link).not_to be_nil, 'Expected to find "Work With Me" CTA button'
    end

    it 'has secondary CTA button linking to Contact' do
      contact_link = homepage_doc.css('a[href="/contact/"]').find do |link|
        link.text.strip.match?(/Contact/i)
      end
      expect(contact_link).not_to be_nil, 'Expected to find "Contact" CTA button'
    end

    it 'contains "What I Do" section with four key areas' do
      expect(homepage).to include('What I Do')
      # Check for both plain text and HTML entity versions
      expect(homepage).to match(/AI Strategy (&|&amp;) Advisory/)
      expect(homepage).to match(/Cloud (&|&amp;) Software Engineering/)
      expect(homepage).to include('Enterprise Automation')
      expect(homepage).to match(/Training (&|&amp;) Upskilling/)
    end
  end

  describe 'Work With Me Page Content' do
    let(:work_with_me) { File.read('_site/work-with-me/index.html') }

    it 'lists all six service categories' do
      # Check for both plain text and HTML entity versions
      expect(work_with_me).to match(/AI Strategy (&|&amp;) Advisory/)
      expect(work_with_me).to match(/LLM (&|&amp;) ML Systems/)
      expect(work_with_me).to include('Cloud Architecture')
      expect(work_with_me).to include('Product Execution')
      expect(work_with_me).to include('Technical Leadership')
      expect(work_with_me).to match(/Training (&|&amp;) Upskilling/)
    end

    it 'contains detailed service descriptions' do
      expect(work_with_me).to include('GenAI Readiness Assessments')
      expect(work_with_me).to include('RAG Implementations')
      expect(work_with_me).to include('AWS-Native Solutions')
      expect(work_with_me).to include('MVP Acceleration')
      expect(work_with_me).to include('Practice Building')
      expect(work_with_me).to include('AI/ML Curriculum Design')
    end

    it 'includes "Who I Work With" section' do
      expect(work_with_me).to include('Who I Work With')
    end

    it 'includes "Approach" section' do
      expect(work_with_me).to include('Approach')
      expect(work_with_me).to include('Strategy → Architecture → Delivery')
    end

    it 'has CTA linking to Contact page' do
      expect(work_with_me).to include('/contact/')
      expect(work_with_me).to match(/Let's talk|Ready to Discuss|Get in Touch/i)
    end
  end

  describe 'Contact Page Content' do
    let(:contact_page) { File.read('_site/contact/index.html') }
    let(:contact_doc) { Nokogiri::HTML(contact_page) }

    it 'has email contact information' do
      expect(contact_page).to include('gafar_meque@hotmail.com')
    end

    it 'has LinkedIn link' do
      linkedin_link = contact_doc.css('a[href*="linkedin.com/in/mekjr1"]')
      expect(linkedin_link).not_to be_empty, 'Expected to find LinkedIn link'
    end

    it 'does not contain contact forms' do
      forms = contact_doc.css('form')
      expect(forms).to be_empty, 'Contact page should not have forms'
    end

    it 'has WhatsApp with click-to-reveal functionality' do
      expect(contact_page).to include('WhatsApp')
      expect(contact_page).to match(/Click to reveal|Available upon request/i)
    end

    it 'includes response time expectation' do
      expect(contact_page).to match(/24-48 hours|respond within/i)
    end
  end

  describe 'About Page Content' do
    let(:about_page) { File.read('_site/about/index.html') }
    let(:about_doc) { Nokogiri::HTML(about_page) }

    it 'has link to My Story page' do
      my_story_link = about_doc.css('a[href="/my-story/"]')
      expect(my_story_link).not_to be_empty, 'Expected to find link to My Story'
    end

    it 'contains professional summary' do
      expect(about_page).to include('Executive Summary')
    end

    it 'contains journey section' do
      expect(about_page).to include('Journey')
      expect(about_page).to include('Mozambique')
      expect(about_page).to include('Mexico')
    end

    it 'contains current focus section' do
      expect(about_page).to include('Current Focus')
    end
  end

  describe 'Writing Page Content' do
    let(:writing_page) { File.read('_site/writing/index.html') }
    let(:writing_doc) { Nokogiri::HTML(writing_page) }

    it 'has hero section with tagline' do
      expect(writing_page).to include('Writing on AI, technology, development, and leadership')
    end

    it 'has three sub-sections: Essays, Medium, LinkedIn' do
      # Check for section navigation or headers
      expect(writing_page).to match(/Essays/i)
      expect(writing_page).to match(/Medium/i)
      expect(writing_page).to match(/LinkedIn/i)
    end

    it 'has navigation for the three sections' do
      # Check for navigation elements
      nav_links = writing_doc.css('.writing-nav-link, .writing-nav a')
      section_ids = writing_doc.css('#essays, #medium, #linkedin')
      
      # Either navigation links or section IDs should exist
      expect(nav_links.length + section_ids.length).to be > 0, 
        'Expected to find navigation for Essays, Medium, and LinkedIn sections'
    end

    it 'has Essays section' do
      expect(writing_page).to include('essays')
    end

    it 'has Medium section' do
      expect(writing_page).to include('medium')
    end

    it 'has LinkedIn section' do
      expect(writing_page).to include('linkedin')
    end
  end

  describe 'Academic CV Page Content' do
    let(:academic_cv) { File.read('_site/academic-cv/index.html') }
    let(:academic_cv_doc) { Nokogiri::HTML(academic_cv) }

    it 'has PDF download link' do
      pdf_link = academic_cv_doc.css('a[href*=".pdf"]').find do |link|
        link.text.match?(/Download PDF/i) || link['href'].include?('Academic_CV')
      end
      expect(pdf_link).not_to be_nil, 'Expected to find PDF download link'
    end

    it 'contains Education section' do
      expect(academic_cv).to include('Education')
    end

    it 'contains Research Experience section' do
      expect(academic_cv).to include('Research Experience')
    end

    it 'contains Publications section' do
      expect(academic_cv).to include('Publications')
    end

    it 'contains Teaching Experience section' do
      expect(academic_cv).to include('Teaching Experience')
    end

    it 'contains Technical Skills section' do
      expect(academic_cv).to include('Technical Skills')
    end
  end

  describe 'Navigation Links Validation' do
    let(:navigation_yml) { YAML.load_file('_data/navigation.yml') }
    let(:main_nav) { navigation_yml['main'] }

    it 'all navigation links work (no 404s)' do
      main_nav.each do |nav_item|
        url = nav_item['url']
        # Convert URL to file path
        file_path = if url == '/'
                      '_site/index.html'
                    else
                      "_site#{url}/index.html"
                    end
        
        expect(File.exist?(file_path)).to be(true), 
          "Expected page to exist at #{file_path} for navigation item '#{nav_item['title']}'"
      end
    end

    it 'navigation contains all required items in correct order' do
      expected_titles = [
        'Home',
        'About',
        'Work With Me',
        'Work & Projects',
        'Publications',
        'Writing',
        'Academic CV',
        'My Story',
        'Contact'
      ]

      actual_titles = main_nav.map { |item| item['title'] }
      expect(actual_titles).to eq(expected_titles)
    end
  end

  describe 'External Links Behavior' do
    let(:pages_to_check) do
      [
        '_site/index.html',
        '_site/work-with-me/index.html',
        '_site/contact/index.html',
        '_site/about/index.html',
        '_site/writing/index.html'
      ]
    end

    it 'external links open in new tabs' do
      pages_to_check.each do |page_path|
        next unless File.exist?(page_path)
        
        doc = Nokogiri::HTML(File.read(page_path))
        
        # Find all external links (not starting with /, #, or relative paths)
        # Exclude footer and sidebar links as they are part of the theme template
        external_links = doc.css('a[href]').select do |link|
          href = link['href']
          # Skip footer and sidebar links (theme template)
          next if link.ancestors('.page__footer').any?
          next if link.ancestors('.sidebar').any?
          next if link.ancestors('.author__urls').any?
          
          href && (href.start_with?('http://') || href.start_with?('https://')) &&
            !href.include?('abdulmeque.com') && !href.include?('mekjr1.github.io') &&
            !href.include?('localhost')
        end

        external_links.each do |link|
          expect(link['target']).to eq('_blank'), 
            "External link #{link['href']} in #{page_path} should have target='_blank'"
        end
      end
    end

    it 'internal links do not have target="_blank"' do
      pages_to_check.each do |page_path|
        next unless File.exist?(page_path)
        
        doc = Nokogiri::HTML(File.read(page_path))
        
        # Find all internal links (starting with / or relative paths)
        internal_links = doc.css('a[href^="/"], a[href^="#"]')

        internal_links.each do |link|
          # Internal links should not have target="_blank" unless they're special cases
          if link['target'] == '_blank'
            # Allow exceptions for specific cases like PDF downloads
            expect(link['href']).to match(/\.pdf$/i), 
              "Internal link #{link['href']} in #{page_path} should not have target='_blank' unless it's a PDF"
          end
        end
      end
    end
  end

  describe 'Content Completeness' do
    it 'homepage contains professional tagline and CTAs (Requirements 1.1, 1.2)' do
      homepage = File.read('_site/index.html')
      expect(homepage).to include('AI Consultant · Cloud Architect · Applied Researcher · Writer')
      expect(homepage).to include('Work With Me')
      expect(homepage).to include('Contact')
    end

    it 'Work With Me page lists all six service categories (Requirement 1.3)' do
      work_with_me = File.read('_site/work-with-me/index.html')
      # Check for both plain text and HTML entity versions
      expect(work_with_me).to match(/AI Strategy (&|&amp;) Advisory/)
      expect(work_with_me).to match(/LLM (&|&amp;) ML Systems/)
      expect(work_with_me).to include('Cloud Architecture')
      expect(work_with_me).to include('Product Execution')
      expect(work_with_me).to include('Technical Leadership')
      expect(work_with_me).to match(/Training (&|&amp;) Upskilling/)
    end

    it 'Writing page has three sub-sections (Requirement 4.1)' do
      writing_page = File.read('_site/writing/index.html')
      expect(writing_page).to match(/Essays/i)
      expect(writing_page).to match(/Medium/i)
      expect(writing_page).to match(/LinkedIn/i)
    end

    it 'About page has link to My Story (Requirement 5.2)' do
      about_page = File.read('_site/about/index.html')
      expect(about_page).to include('/my-story/')
    end

    it 'Contact page has email and LinkedIn, no forms (Requirements 7.1, 7.4)' do
      contact_page = File.read('_site/contact/index.html')
      doc = Nokogiri::HTML(contact_page)
      
      expect(contact_page).to include('gafar_meque@hotmail.com')
      expect(contact_page).to include('linkedin.com/in/mekjr1')
      expect(doc.css('form')).to be_empty
    end
  end
end
